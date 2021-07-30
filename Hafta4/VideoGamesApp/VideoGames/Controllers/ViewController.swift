import UIKit
import Foundation
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var uiView: UIView!
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Üzgünüz, aradığınız oyun bulunamadı!"
        label.font = UIFont(name: "AvenirNextCondensed-Heavy", size: 24)
        label.isHidden = true
        return label
    }()
    let indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.color = .darkGray
        view.hidesWhenStopped = true
        view.style = .large
        return view
    }()
    
    
    private var collectionView: UICollectionView?
    var search: Bool = false
    var movieList: [Game]? = []
    var searchResults: [Game?] = []
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureViewController()
        configureSearchBar()
        configureCollectionView()
    
    }
        
    private func configureViewController(){
        navigationItem.title = "Games"
        indicatorView.startAnimating()
        view.fadeOut(duration: 0)
        view.backgroundColor = .systemBackground
        navigationItem.hidesSearchBarWhenScrolling = false
        view.addSubview(indicatorView)
    }
    
    private func configureCollectionView(){
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: customLayout())
        collectionView?.backgroundColor = .systemBackground
        collectionView?.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        guard let collectionView = collectionView else {return}
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
    }
    
    private func configureSearchBar(){
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Games"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        NetworkManager.shared.getMovieList { (movieList) in
            if let movies = movieList {
                for movie in movies{
                    self.movieList?.append(movie)
                }
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                    self.indicatorView.stopAnimating()
                    self.view.fadeIn()
                }
                if segue.identifier == "ShowCustomPageViewController"{
                    guard let imagesVC = segue.destination as? CustomPageViewController else { return }
                    guard let movies = movieList else {return}
                    if movies.count > 0 {
                        imagesVC.images =  [movies[0].image ,
                                            movies[1].image,
                                            movies[2].image]
                    }
                    imagesVC.customPageViewControllerDelegate = self
                    
                    imagesVC.turnToPage(index: 0)
                }
            }
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        let tabBarHeight = self.tabBarController?.tabBar.height ?? 0.0
        indicatorView.frame = CGRect(x: view.width/2-25,
                                     y: view.height/2,
                                     width: 50,
                                     height: 50)
        if !search {
            collectionView?.frame = CGRect(x: view.left,
                                           y: uiView.bottom + 5,
                                           width: view.width,
                                           height: view.height-(uiView.height)-tabBarHeight-70)
        }
        
    }
    
    private func customLayout() -> UICollectionViewFlowLayout{
        let tabBarHeight = self.tabBarController?.tabBar.height ?? 0.0
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 2
        layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 1, right: 1)
        let itemWidth = (view.width)
        let itemHeight = CGFloat((view.height-(uiView.height)-tabBarHeight)/5)
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        return layout
    }
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !searchResults.isEmpty{
            return searchResults.count
        }
        return movieList!.count-3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        if !searchResults.isEmpty{
            cell.initializeCell(game: searchResults[indexPath.row]!)
        }else{
            cell.initializeCell(game: movieList![indexPath.row+3])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailGameViewController()
        detailVC.modalPresentationStyle = .popover
        detailVC.selectedMovieName = searchResults.count > 0 ? searchResults[indexPath.row]?.slug : movieList![indexPath.row+3].slug
        
        present(detailVC, animated: true, completion: nil)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard let searchText = searchBar.text else { return }
        if searchText.count > 2 {
            searchResults = movieList!.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            }
            
            if searchResults.isEmpty{
                self.uiView.isHidden = true
                self.pageController.isHidden = true
                self.collectionView?.isHidden = true
                
                self.label.frame = view.bounds
                self.label.isHidden = false
                self.view.addSubview(label)
            }else{
                reDrawLayout(search: true)
            }
            
        }
        else if (searchText.count == 0){
            reDrawLayout(search: false)
        }
        else{
            search = false
            self.uiView.isHidden = false
            self.pageController.isHidden = false
            searchResults.removeAll()
        }
        
        self.collectionView?.reloadData()
        
    }
    private func reDrawLayout(search: Bool){
        self.label.isHidden = true
        view.willRemoveSubview(label)
        self.collectionView?.isHidden = false
        if search{
            self.search = true
            self.uiView.isHidden = true
            self.pageController.isHidden = true
            let newFrame = CGRect(x:view.left,
                                  y: view.top+10,
                                  width:view.width,
                                  height:view.height)
            collectionView?.frame = newFrame
        }else{
            self.search = false
            self.uiView.isHidden = false
            self.pageController.isHidden = false
            searchResults.removeAll()
            collectionView?.frame = CGRect(x: view.left,
                                           y: uiView.bottom + 5,
                                           width: view.width,
                                           height: view.height-(uiView.height)-20)
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchResults.removeAll()
        self.collectionView?.reloadData()
        reDrawLayout(search: false)
    }
    
}

extension ViewController: CustomPageViewControllerDelegate {
    
    func setupPageController(numberOfPages: Int) {
        pageController.numberOfPages = numberOfPages
    }
    
    func turnPageController(to index: Int) {
        pageController.currentPage = index
    }
}
