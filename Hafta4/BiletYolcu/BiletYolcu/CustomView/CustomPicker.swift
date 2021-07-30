//
//  CustomPicker.swift
//  BiletYolcu
//
//  Created by Egemen Inceler on 23.07.2021.
//

import UIKit

class CustomPicker: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        let picker = UIDatePicker()
    
        addSubview(picker)
    }
    
}

