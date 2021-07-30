import UIKit
/**
 Yapılacaklar:
 
    2.
        2.1 Test
 */

class ViewController: UIViewController {

    var collectionView : UICollectionView!
    
    var movieList    = [Movie]()
    var filteredList = [Movie]()
    var favoriedList = [Int?]()
    var page = 1
    let loadingView = UIActivityIndicatorView()
    var isGrid = true
    var isFiltering: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        configureLoadingView()
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.title = "Contents"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: SFSymbols.list, style: .plain, target: self, action: #selector(barButtonClicked))
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView(layout: createCollectonGridLayout())
        
        DatabaseManager.shared.getData { [weak self] (list) in
            guard let self = self else { return }
            if list.count > 0 {
                self.favoriedList = list
            }
        }
        loadingView.startAnimating()
        updateUI()
    }
    
    @objc func barButtonClicked(){
        isGrid = !isGrid
        
        if isGrid{
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: SFSymbols.list, style: .plain, target: self, action: #selector(barButtonClicked))
            collectionView.collectionViewLayout = createCollectonGridLayout()
        }else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: SFSymbols.grid, style: .plain, target: self, action: #selector(barButtonClicked))
            collectionView.collectionViewLayout = createCollectionListLayout()
        
        }
    }
    
    private func updateUI(){
        NetworkManager.shared.getMovieList(page_num: String(page)) { [weak self] (movies) in
            guard let self = self else { return }
        
            if let movies = movies{
                 for movie in movies{
                    let instance = Movie(id: movie.id, url: movie.poster_path, title: movie.title)
                    if self.favoriedList.contains(movie.id){
                        instance.isFavoried = true
                    }
                    self.movieList.append(instance)
                 }
                 DispatchQueue.main.async {
                     self.collectionView.reloadData()
                     self.loadingView.stopAnimating()
                 }
            }else{
                    print("olmadı")
            }
         }
    }
    
    private func configureLoadingView(){
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingView.widthAnchor.constraint(equalToConstant: 100),
            loadingView.heightAnchor.constraint(equalToConstant: 100),
            
        ])
        loadingView.style = .medium
    }
    
    

    func configureCollectionView(layout: UICollectionViewFlowLayout){
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height-40), collectionViewLayout: layout)
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
        collectionView.delegate  = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
    }
    
    func createCollectonGridLayout() -> UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
        let width  = (view.frame.width - 4*10)/2
        let height = (view.frame.height)/3
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumInteritemSpacing = 5
        
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.scrollDirection = .vertical
        
        
        return layout
    }
    
    func createCollectionListLayout() -> UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
        let width  = (view.frame.width - 2*10)
        let height = (view.frame.height)/3.5
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumInteritemSpacing = 5
        
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.scrollDirection = .vertical
        
        return layout
    }

}

extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        isFiltering = true
        
        filteredList = movieList.filter { (movie: Movie) -> Bool in
            return movie.imageTitle.lowercased().contains(searchBar.text!.lowercased())
          }
          
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        isFiltering = false
        
        searchBar.text = ""
        DispatchQueue.main.async {
            self.collectionView.restore()
            self.collectionView.reloadData()
        }
    }
}

extension UICollectionView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        messageLabel.text = message
        messageLabel.textColor = .label
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
    
        messageLabel.backgroundColor = .systemBackground
        
        self.backgroundView = messageLabel;
    }

    func restore() {
        self.backgroundView = nil
    }
}
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
         if isFiltering{
             if filteredList.count == 0 {
                 self.collectionView.setEmptyMessage("Nothing to show:(")
             }else{
                 self.collectionView.restore()
                 
             }
             return filteredList.count
         
         }else{
            return movieList.count
         }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        var list = [Movie]()
        if isFiltering && filteredList.count > 0 {
            list = filteredList
        }else{
            list = movieList
        }
        cell.setUI(list[indexPath.row].imageURL, list[indexPath.row].imageTitle, favoried: list[indexPath.row].isFavoried)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailVC()
        detailVC.setValues(movie: movieList[indexPath.row])
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == movieList.count-4{
            print(self.page)
            self.page += 1
            updateUI()
        }
    }
}
