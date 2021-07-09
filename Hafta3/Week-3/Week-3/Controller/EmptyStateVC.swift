//
//  EmptyStateVC.swift
//  Week-3
//
//  Created by Egemen Inceler on 5.07.2021.
//

import UIKit

class EmptyStateVC: UIView {
    let imageView = UIImageView()
    let messageText =  UILabel()
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(message: String, image: UIImage){
        self.init(frame: .zero)
        configureMessageText(message)
        configureImageView(image)
    }
    
    func configureMessageText(_ message: String){
        addSubview(messageText)
        
        messageText.text = message
        messageText.textColor = .secondaryLabel
        messageText.numberOfLines = 0
        messageText.textAlignment = .center
        messageText.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        
        messageText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageText.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50),
            messageText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            messageText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            messageText.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    func configureImageView(_ image: UIImage){
        imageView.image = image
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .lightGray
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: messageText.bottomAnchor, constant: 10),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}

