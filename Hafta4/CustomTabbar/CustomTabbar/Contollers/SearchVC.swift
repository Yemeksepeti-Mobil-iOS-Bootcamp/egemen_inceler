//
//  SearchVC.swift
//  CustomTabbar
//
//  Created by Egemen Inceler on 30.07.2021.
//

import UIKit

class SearchVC: UIViewController {
    let textView = UITextView()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureTextView()
    }

    
    private func configureTextView(){
        view.addSubview(textView)
        textView.text = "SearchVC"
        textView.textAlignment = .center
        textView.font = UIFont(name: "Helvetica", size: 24)
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            textView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}
