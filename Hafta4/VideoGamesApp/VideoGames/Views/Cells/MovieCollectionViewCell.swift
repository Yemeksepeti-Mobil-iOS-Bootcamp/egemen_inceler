import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    static let identifier = "MovieCollectionViewCell"
    
    let imageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    let nameTitle: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        
        return textView
    }()
    let ratingTitle: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        return textView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(){
        addSubviews()
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.33),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -5),
            
            nameTitle.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameTitle.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            nameTitle.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.66),
            nameTitle.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
            
            ratingTitle.topAnchor.constraint(equalTo: nameTitle.topAnchor),
            ratingTitle.leadingAnchor.constraint(equalTo: nameTitle.trailingAnchor, constant: 10),
            ratingTitle.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.66),
            ratingTitle.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
        ])
        
        nameTitle.centerVerticalText()
        ratingTitle.centerVerticalText()
    }

    
    private func addSubviews() {
        contentView.addSubview(imageView)
        contentView.addSubview(nameTitle)
        contentView.addSubview(ratingTitle)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameTitle.translatesAutoresizingMaskIntoConstraints = false
        ratingTitle.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func initializeCell(game: Game){
        self.imageView.kf.setImage(with: URL(string: game.image))
        self.nameTitle.text = game.name
        self.ratingTitle.text = String(game.rating) + " " + game.released
    }
}
