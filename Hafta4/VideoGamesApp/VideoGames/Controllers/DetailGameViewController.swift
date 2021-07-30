import UIKit

protocol DidTapFavoriteButtonDelegate: class {
    func didTapFavoriteButton()
}

class DetailGameViewController: UIViewController {
    weak var didTapFavoriteButtonDelegate: DidTapFavoriteButtonDelegate?
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let favoriteButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        button.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .lightGray
        return button
    }()
    let nameText: UITextView = {
        let text = UITextView()
        text.font = UIFont(name: "AvenirNextCondensed-Heavy", size: 24)
        return text
    }()
    let releaseText: UITextView = {
        let text = UITextView()
        text.font = UIFont(name: "Avenir-Light", size: 16)
        return text
    }()
    let ratingText: UITextView = {
        let text = UITextView()
        text.font = UIFont(name: "Avenir-Light", size: 16)
        return text
    }()
    let descriptionText: UITextView = {
        let text = UITextView()
        text.font = UIFont(name: "Avenir-Light", size: 16)
        return text
    }()
    
    var selectedMovieName: String?
    var game: GameDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        addSubviews()
        configureUI()
        
        favoriteButton.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
        NetworkManager.shared.getMovieDetail(bookName: selectedMovieName!) { (response) in
            if(response != nil){
                self.initializeViewController(game: response!)
                self.game = response
                DatabaseManager.shared.searchData(slug: self.game!.slug) { (success) in
                    if success{
                        //self.favoriteButton.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
                        self.favoriteButton.setBackgroundImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
                    }
                }
            }
        }
        
        
    }
    
    @objc private func didTapFavoriteButton(){
        DatabaseManager.shared.searchData(slug: game!.slug) { (success) in
            if(success){
                DatabaseManager.shared.deleteData(slug: game!.slug) { (success) in
                    if success {
                        makeAlert(title: "Oyun başarıyla silindi.", message: "")
                        self.didTapFavoriteButtonDelegate?.didTapFavoriteButton()
                        self.favoriteButton.setBackgroundImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
                    }
                }
            }else{
                DatabaseManager.shared.insertData(game: game!) { (success) in
                    if (success){
                        makeAlert(title: "Oyun başarıyla eklendi.", message: "")
                        self.didTapFavoriteButtonDelegate?.didTapFavoriteButton()
                        self.favoriteButton.setBackgroundImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
                    }
                }
            }
        }
    }
    
    private func makeAlert(title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func configureUI(){
        let padding: CGFloat = 5
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.33), //view.height/3
            
            
            favoriteButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -50),
            favoriteButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -50),
            favoriteButton.widthAnchor.constraint(equalToConstant: 50),
            favoriteButton.heightAnchor.constraint(equalToConstant: 50),
            
            nameText.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding*2),
            nameText.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nameText.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameText.heightAnchor.constraint(equalToConstant: 40),
            
            releaseText.topAnchor.constraint(equalTo: nameText.bottomAnchor, constant: 1),
            releaseText.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            releaseText.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            releaseText.heightAnchor.constraint(equalToConstant: 30),
            
            ratingText.topAnchor.constraint(equalTo: releaseText.bottomAnchor, constant: 1),
            ratingText.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ratingText.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ratingText.heightAnchor.constraint(equalToConstant: 30),
            
            descriptionText.topAnchor.constraint(equalTo: ratingText.bottomAnchor, constant: 1),
            descriptionText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            descriptionText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            descriptionText.heightAnchor.constraint(equalToConstant: 400),
            
        ])
        
    }
    
    func initializeViewController(game: GameDetail){
        
        imageView.kf.setImage(with: URL(string: game.img))
        nameText.text = game.name
        releaseText.text = game.released
        ratingText.text = String(game.metacritic)
        descriptionText.text = game.description.fromHTML().string
        
    }
    
    private func addSubviews(){
        view.addSubview(imageView)
        view.addSubview(favoriteButton)
        view.addSubview(nameText)
        view.addSubview(releaseText)
        view.addSubview(ratingText)
        view.addSubview(descriptionText)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        nameText.translatesAutoresizingMaskIntoConstraints = false
        releaseText.translatesAutoresizingMaskIntoConstraints = false
        ratingText.translatesAutoresizingMaskIntoConstraints = false
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
    }
}

