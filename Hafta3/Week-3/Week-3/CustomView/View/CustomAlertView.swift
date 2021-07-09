//
//  CustomAlertView.swift
//  Week-3
//
//  Created by Egemen Inceler on 7.07.2021.
//

import UIKit

class CustomAlertView: UIViewController {
    let containerView = UIView()
    let adresBaslik = UITextField()
    let adres = UILabel()
    let bina  = UITextField()
    let kat   = UITextField()
    let daire = UITextField()
    let tarif = UITextField()
    let cancelButton = UIButton()
    let okButton     = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configure()
    }
    
    init(adres: String, _ bina: String){
        super.init(nibName: nil, bundle: nil)
        self.adres.text = adres
        self.adres.numberOfLines = 0
        self.bina.text = bina
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        view.addSubview(containerView)
        
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor     = .systemBackground
        containerView.layer.cornerRadius  = 16
        containerView.layer.borderWidth   = 2
        containerView.layer.borderColor   = UIColor.white.cgColor
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 300),
            containerView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        configureTitle()
        configureAdres()
        configureBina()
        configureTarif()
        configureButtons()
    }
    
    
    func configureTitle(){
        containerView.addSubview(adresBaslik)
        adresBaslik.translatesAutoresizingMaskIntoConstraints = false
        
        adresBaslik.placeholder = "Başlık(Ev, İşyeri)"
        adresBaslik.borderStyle = .roundedRect
        
        let padding = CGFloat(10)
        NSLayoutConstraint.activate([
            adresBaslik.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            adresBaslik.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            adresBaslik.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            adresBaslik.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configureAdres(){
        containerView.addSubview(adres)
        adres.translatesAutoresizingMaskIntoConstraints = false
        
        adres.layer.borderWidth  = 1
        adres.layer.borderColor  = UIColor.lightGray.cgColor
        adres.layer.cornerRadius = 8
        let padding = CGFloat(10)
        NSLayoutConstraint.activate([
            adres.topAnchor.constraint(equalTo: adresBaslik.bottomAnchor, constant: padding),
            adres.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            adres.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            adres.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureBina(){
        containerView.addSubview(bina)
        containerView.addSubview(kat)
        containerView.addSubview(daire)
        
        bina.placeholder  = "Bina No"
        bina.borderStyle  = .roundedRect
        
        kat.placeholder   = "Kat"
        kat.borderStyle   = .roundedRect
        
        daire.placeholder = "Daire No"
        daire.borderStyle = .roundedRect
        
        bina.translatesAutoresizingMaskIntoConstraints  = false
        kat.translatesAutoresizingMaskIntoConstraints   = false
        daire.translatesAutoresizingMaskIntoConstraints = false
        
        let padding = CGFloat(10)
        let sizeWidth = (300 - 6*padding)/3
        
        let size = CGFloat(50)
        NSLayoutConstraint.activate([
            bina.topAnchor.constraint(equalTo: adres.bottomAnchor, constant: padding),
            bina.leadingAnchor.constraint(equalTo: adres.leadingAnchor, constant: padding),
            bina.widthAnchor.constraint(equalToConstant: sizeWidth),
            bina.heightAnchor.constraint(equalToConstant: size),
            
            kat.topAnchor.constraint(equalTo: adres.bottomAnchor, constant: padding),
            kat.leadingAnchor.constraint(equalTo: bina.trailingAnchor, constant: padding),
            kat.widthAnchor.constraint(equalToConstant: sizeWidth),
            kat.heightAnchor.constraint(equalToConstant: size),
            
            daire.topAnchor.constraint(equalTo: adres.bottomAnchor, constant: padding),
            daire.leadingAnchor.constraint(equalTo: kat.trailingAnchor, constant: padding),
            daire.widthAnchor.constraint(equalToConstant: sizeWidth),
            daire.heightAnchor.constraint(equalToConstant: size),
            
        ])
    }
    
    func configureTarif(){
        containerView.addSubview(tarif)
        tarif.translatesAutoresizingMaskIntoConstraints = false
        
        tarif.placeholder = "Adres Tarifi"
        tarif.borderStyle = .roundedRect
        let padding = CGFloat(10)
        NSLayoutConstraint.activate([
            tarif.topAnchor.constraint(equalTo: bina.bottomAnchor, constant: padding),
            tarif.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            tarif.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            tarif.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    func configureButtons(){
        containerView.addSubview(cancelButton)
        containerView.addSubview(okButton)
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        okButton.translatesAutoresizingMaskIntoConstraints = false
        
        cancelButton.setTitle("İptal", for: .normal)
        cancelButton.backgroundColor = .systemPink
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.layer.cornerRadius      = 10
        cancelButton.titleLabel?.font        = UIFont.preferredFont(forTextStyle: .headline)
        cancelButton.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
        
        okButton.setTitle("Kaydet", for: .normal)
        okButton.backgroundColor = .systemGreen
        okButton.setTitleColor(.white, for: .normal)
        okButton.layer.cornerRadius      = 10
        okButton.titleLabel?.font        = UIFont.preferredFont(forTextStyle: .headline)
        okButton.addTarget(self, action: #selector(okButtonClicked), for: .touchUpInside)
        
        let padding = CGFloat(10)
        let buttonWidth = (300-4*padding)/2
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: tarif.bottomAnchor, constant: padding),
            cancelButton.leadingAnchor.constraint(equalTo: tarif.leadingAnchor, constant: padding),
            cancelButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            cancelButton.heightAnchor.constraint(equalToConstant: 40),
            
            okButton.topAnchor.constraint(equalTo: tarif.bottomAnchor, constant: padding),
            okButton.leadingAnchor.constraint(equalTo: cancelButton.trailingAnchor, constant: padding),
            okButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            okButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    @objc func cancelButtonClicked(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func okButtonClicked(){
        dismiss(animated: true, completion: nil)
    }
}
