//
//  CustomView.swift
//  BiletYolcu
//
//  Created by Egemen Inceler on 23.07.2021.
//

import UIKit

protocol ButtonClick: class{
    func buttonClicked(_ type: PickerType, _ id: Int)
}

class CustomView: UIView {
    let title: UILabel          = UILabel()
    let button: UIButton        = UIButton()
    
    var type: PickerType?
    var id: Int?
    weak var buttonClickedDelegate: ButtonClick?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(type: PickerType, _ id: Int) {
        self.init()
        self.type = type
        self.id = id
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setText(by toOrFrom: String){
        self.title.text = toOrFrom
    }
    
    private func configure(){
        addSubview(title)
        addSubview(button)
        
        title.translatesAutoresizingMaskIntoConstraints  = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        title.font = UIFont(name: "HelveticaNeue", size: 14)
        title.textAlignment = .center
        

        button.backgroundColor = .lightGray
        button.setTitle("...", for: .normal)
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        button.setTitleColor(.label, for: .normal)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            title.widthAnchor.constraint(equalTo: self.widthAnchor),
            title.heightAnchor.constraint(equalToConstant: 20),
            
            button.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            button.widthAnchor.constraint(equalTo: self.widthAnchor),
            button.heightAnchor.constraint(equalToConstant: 70),
            
            
            
        ])
    }
    
    @objc private func buttonClicked(){
        buttonClickedDelegate?.buttonClicked(self.type!, self.id!)
        // after picker protocol?
        
    }
    
}
