import UIKit

class MovieCell: UICollectionViewCell {
    static let identifier = "MovieCell"
    
    let imageView      = UIImageView()
    let movieTitle     = UITextView()
    let star           = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    convenience init(imageURL: String, title: String){
        self.init(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI(_ imageURL: String, _ title: String, favoried: Bool){
        imageView.image = NetworkManager.shared.downloadImage(imageURL)
        movieTitle.text = title
        
        if favoried{
            star.image = SFSymbols.starfill
        }else{
            star.image = SFSymbols.star
        }
    }
    
    
    private func configure(){
        contentView.addSubview(imageView)
        contentView.addSubview(movieTitle)
        contentView.addSubview(star)
        
        imageView.translatesAutoresizingMaskIntoConstraints      = false
        movieTitle.translatesAutoresizingMaskIntoConstraints     = false
        star.translatesAutoresizingMaskIntoConstraints           = false
        movieTitle.isScrollEnabled = false
        movieTitle.backgroundColor = .secondarySystemBackground
        
        
        
        let padding: CGFloat = 5
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            
            
            
            movieTitle.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -5),
            movieTitle.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            movieTitle.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            movieTitle.heightAnchor.constraint(equalToConstant: 25),
            
            star.topAnchor.constraint(equalTo: imageView.topAnchor, constant: padding),
            star.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -padding),
            star.widthAnchor.constraint(equalToConstant: 30),
            star.heightAnchor.constraint(equalToConstant: 30)
            
        ])
    }
}
