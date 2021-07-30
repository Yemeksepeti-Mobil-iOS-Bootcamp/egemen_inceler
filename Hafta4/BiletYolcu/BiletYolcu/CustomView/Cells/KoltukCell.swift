//
//  KoltukCell.swift
//  BiletYolcu
//
//  Created by Egemen Inceler on 22.07.2021.
//

import UIKit

class KoltukCell: UICollectionViewCell {
    static let identifier = "KoltukCell"
    
    let number: UITextView = UITextView()
    let imageView: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 2
        contentView.layer.borderWidth  = 1
        contentView.layer.borderColor  = UIColor.blue.cgColor
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(){
        contentView.addSubview(number)
        contentView.addSubview(imageView)
        
        number.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        number.font = UIFont(name: "HelveticaNeue", size: 12)
        number.backgroundColor = .clear
        number.textColor = .black
        number.textAlignment = .center
        number.isEditable = false
        number.isScrollEnabled = false
        
        imageView.image = Images.empty
        NSLayoutConstraint.activate([
            number.topAnchor.constraint(equalTo: contentView.topAnchor),
            number.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            number.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            number.heightAnchor.constraint(equalToConstant: 20),
            
            imageView.topAnchor.constraint(equalTo: number.bottomAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
}
