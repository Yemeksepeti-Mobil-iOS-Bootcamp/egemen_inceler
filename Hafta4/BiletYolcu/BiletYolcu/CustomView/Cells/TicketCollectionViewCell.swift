//
//  TicketCollectionViewCell.swift
//  BiletYolcu
//
//  Created by Egemen Inceler on 27.07.2021.
//

import UIKit

class TicketCollectionViewCell: UICollectionViewCell {
    static let identifier = "TicketCollectionViewCell"
    
    let imageView = UIImageView()
    let nameLabel = UILabel()
    
    let koltukLabel = UILabel()
    let tarihLabel  = UILabel()
    let pnrLAbel    = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        configureImageView()
        configureNameLabel()
        configureKoltukLabel()
        configureTarih()
        configurePNR()
    }
    
    func setUI(ticket: Bilet){
        let te = (ticket.yolcu!.adi) + " " + (ticket.yolcu!.soyadi)
        nameLabel.text = " Yolcu adı: " + te
        koltukLabel.text = " Koltuk Numarası: " + String(ticket.koltuk)
        tarihLabel.text = " Tarih: " + (ticket.tarih?.toString())!  + " Saat: " + (ticket.saat?.toString())!
    }
    
    private func configureImageView(){
        contentView.addSubview(imageView)
        
        imageView.image = Images.tick
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func configureNameLabel(){
        contentView.addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont(name: "HelveticaNeue", size: 12)
        nameLabel.layer.borderWidth = 1
        nameLabel.layer.borderColor = UIColor.darkGray.cgColor
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            nameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    
    private func configureKoltukLabel(){
        contentView.addSubview(koltukLabel)
        
        koltukLabel.translatesAutoresizingMaskIntoConstraints = false
        
        koltukLabel.font = UIFont(name: "HelveticaNeue", size: 12)
        koltukLabel.layer.borderWidth = 1
        koltukLabel.layer.borderColor = UIColor.darkGray.cgColor
        
        
        NSLayoutConstraint.activate([
            koltukLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            koltukLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            koltukLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            koltukLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func configureTarih(){
        contentView.addSubview(tarihLabel)
        
        tarihLabel.translatesAutoresizingMaskIntoConstraints = false
        
        tarihLabel.font = UIFont(name: "HelveticaNeue", size: 12)
        tarihLabel.layer.borderWidth = 1
        tarihLabel.layer.borderColor = UIColor.darkGray.cgColor
        
        
        NSLayoutConstraint.activate([
            tarihLabel.topAnchor.constraint(equalTo: koltukLabel.bottomAnchor, constant: 20),
            tarihLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            tarihLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            tarihLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func configurePNR(){
        contentView.addSubview(pnrLAbel)
        
        pnrLAbel.translatesAutoresizingMaskIntoConstraints = false
        pnrLAbel.text = "PNR Numarası: \(Int.random(in: 12345...22347))"
        NSLayoutConstraint.activate([
            pnrLAbel.topAnchor.constraint(equalTo: tarihLabel.bottomAnchor, constant: 5),
            pnrLAbel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            pnrLAbel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            pnrLAbel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
}
