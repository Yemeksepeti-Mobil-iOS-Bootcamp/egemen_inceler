import UIKit

class FavoriteGamesViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    var favoriteGames: [Game]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationItem.title = "Favorites"
        
        
        configureCollectionView()
    }
    
    private func configureCollectionView(){
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: customLayout())
        collectionView?.backgroundColor = .systemBackground
        collectionView?.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        guard let collectionView = collectionView else { return }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDataFromCoredata()
    }
    
    private func getDataFromCoredata(){
        
        favoriteGames?.removeAll()
        
        DatabaseManager.shared.getData { (gameList) in
            guard let games = gameList else { return }
            self.favoriteGames = games
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
    private func customLayout() -> UICollectionViewFlowLayout{
        let tabBarHeight = self.tabBarController?.tabBar.height ?? 0.0
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 2
        layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 1, right: 1)
        layout.estimatedItemSize = .zero
        let itemWidth = (view.width)
        let itemHeight = CGFloat((view.height-tabBarHeight)/8)
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        return layout
    }
}

extension FavoriteGamesViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteGames?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        cell.initializeCell(game: favoriteGames![indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailGameViewController()
        detailVC.modalPresentationStyle = .popover
        detailVC.selectedMovieName = favoriteGames!.count > 0 ? favoriteGames![indexPath.row].slug : ""
        detailVC.didTapFavoriteButtonDelegate = self
        present(detailVC, animated: true, completion: nil)
    }
    
}
extension FavoriteGamesViewController: DidTapFavoriteButtonDelegate{
    func didTapFavoriteButton() {
        self.getDataFromCoredata()
    }
}
