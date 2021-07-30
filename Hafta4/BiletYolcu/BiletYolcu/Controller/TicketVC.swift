import UIKit

class TicketVC: UIViewController {

    var tickets: [Bilet?] = []
    
    
    var collectionView: UICollectionView!
    
    init(bilet: [Bilet?] ) {
        super.init(nibName: nil, bundle: nil)
        self.tickets = bilet
        
        print("biletler: ", bilet)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureCollectionView()
        
        
       /*
         Direkt bileti göster
         broughtArray'e ekle
         */
    }
    
    private func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: customLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TicketCollectionViewCell.self, forCellWithReuseIdentifier: TicketCollectionViewCell.identifier)
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
    }
    
    
    private func customLayout() -> UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 2
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let itemWidth = view.frame.width
        let itemHeight = CGFloat((view.frame.height)/3)
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        return layout
    
    }
    
    
}

extension TicketVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tickets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TicketCollectionViewCell.identifier, for: indexPath) as! TicketCollectionViewCell
        cell.setUI(ticket: tickets[indexPath.row]!)
        return cell
    }
    
    
    
}
