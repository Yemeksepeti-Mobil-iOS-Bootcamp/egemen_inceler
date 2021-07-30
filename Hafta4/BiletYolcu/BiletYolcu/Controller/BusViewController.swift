//
//  BusViewController.swift
//  BiletYolcu
//
//  Created by Egemen Inceler on 23.07.2021.
//

import UIKit
import ActionSheetPicker_3_0

class BusViewController: UIViewController {
    
    let fromView = CustomView(type: .location, 0)
    let changeImage = UIImageView()
    let toView   = CustomView(type: .location, 1)
    
    var selectedArray: [Int] = []
    var boughtArray: [Int] = [7, 12, 15]
    var rezervasyonArray: [Int] = [1]
    
    let datePicker     = UIDatePicker()
    var collectionView: UICollectionView!
    let button = UIButton()
    let rezervasyonButton = UIButton()
    
    var index: IndexPath = IndexPath()
    var date: String    = ""
    var hours: String   = ""
    var bilet = Bilet(yolcu: nil, tarih: nil, saat: nil)
    var satinAlinacak: [Bilet?] = []
    let dizi: [String] = ["Adana","Ağrı","Balıkesir","Çanakkale","Yalova","Bingöl","Sivas","Muğla","Aydın","Tekirdağ", "Marmaraereğlisi", "Çorlu"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fromView.buttonClickedDelegate = self
        toView.buttonClickedDelegate   = self
        
        
        configureFromView()
        configureImage()
        configureToView()
        
        configureDatePicker()
        configureCollectionView()
        configureButton()
        configureRezervasyonButton()
    }
    
    private func configureButton(){
        view.addSubview(button)
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 10
        
        button.setTitle("Satın al.", for: .normal)
        button.addTarget(self, action: #selector(buyButtonClicked), for: .touchUpInside)
        button.backgroundColor = .systemRed
        NSLayoutConstraint.activate([
            
            button.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: padding),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: 20)
            
        ])
    }
    
    private func configureRezervasyonButton(){
        view.addSubview(rezervasyonButton)
        
        rezervasyonButton.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 10
        
        rezervasyonButton.setTitle("Rezervasyon yap.", for: .normal)
        rezervasyonButton.addTarget(self, action: #selector(rezervasyonButtonClicked), for: .touchUpInside)
        rezervasyonButton.backgroundColor = .systemBlue
        NSLayoutConstraint.activate([
            
            rezervasyonButton.topAnchor.constraint(equalTo: button.bottomAnchor, constant: padding),
            rezervasyonButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rezervasyonButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rezervasyonButton.heightAnchor.constraint(equalToConstant: 20)
            
        ])
    }
    
    @objc func buyButtonClicked(){
        
        if (fromView.button.titleLabel?.text == "..." || toView.button.titleLabel?.text == "..."){
            makeAlert()
        }else {
            let ticketVC = TicketVC(bilet: satinAlinacak)
            guard let _ = bilet.yolcu else {
                makeAlert()
                return
            }
            
            present(ticketVC, animated: true)
            
        }
    }
    
    private func makeAlert(){
        let alert = UIAlertController(title: "Seçim yap", message: "Seçim yapmalısınız", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    
    @objc func rezervasyonButtonClicked(){
        
        if selectedArray.count < 6{
            for item in selectedArray{
                rezervasyonArray.append(item)
                let cell = collectionView.cellForItem(at: IndexPath(row: item , section: 0)) as! KoltukCell
                cell.imageView.image = Images.reserve
                cell.isUserInteractionEnabled = false
            }
            satinAlinacak.removeAll()
        }else {
            let alert = UIAlertController(title: "Hob hemşerim", message: "En fazla 5 kişilik rezervasyon yapabilirsiniz...", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
            self.present(alert, animated: true)
        }
    }
    
    private func configureCollectionView(){
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: customLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(KoltukCell.self, forCellWithReuseIdentifier: KoltukCell.identifier)
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: padding),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            collectionView.heightAnchor.constraint(equalToConstant: 600)
        ])
    }
    
    private func customLayout() -> UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 2
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let itemWidth = (view.frame.width)/5
        let itemHeight = CGFloat((view.frame.height)/17)
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        return layout
    
    }
    
    
    private func configureDatePicker(){
        view.addSubview(datePicker)
        datePicker.timeZone = TimeZone.current
        datePicker.locale = Locale(identifier: "en_GB")
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: fromView.bottomAnchor, constant: padding),
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
        
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        
        let selectedDate: String = dateFormatter.string(from: sender.date)
        self.date = String(selectedDate.prefix(10))
        self.hours = String(selectedDate.suffix(5))
        print(hours)
    }
    
    
    
    private func configureFromView(){
        view.addSubview(fromView)
        fromView.translatesAutoresizingMaskIntoConstraints = false
        fromView.backgroundColor = .secondarySystemBackground
        fromView.setText(by: "Nereden")
        
        
        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
            fromView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            fromView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding*7),
            fromView.widthAnchor.constraint(equalToConstant: 110),
            fromView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func configureImage(){
        view.addSubview(changeImage)
        changeImage.image = Images.arrow
        changeImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            changeImage.centerYAnchor.constraint(equalTo: fromView.centerYAnchor, constant: 5),
            changeImage.leadingAnchor.constraint(equalTo: fromView.trailingAnchor, constant: 10),
            changeImage.widthAnchor.constraint(equalToConstant: 30),
            changeImage.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func configureToView(){
        view.addSubview(toView)
        toView.translatesAutoresizingMaskIntoConstraints = false
        toView.backgroundColor = .secondarySystemBackground
        toView.setText(by: "Nereye")
        
        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
            toView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            toView.leadingAnchor.constraint(equalTo: changeImage.trailingAnchor, constant: padding),
            toView.widthAnchor.constraint(equalToConstant: 110),
            toView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}

extension BusViewController: ButtonClick{
    
    func buttonClicked(_ type: PickerType, _ id: Int) {
        
        ActionSheetMultipleStringPicker.show(withTitle: "Şehir seçiniz", rows: [dizi]
                                             , initialSelection: [2, 2], doneBlock: { [weak self] picker, indexes, values in
                guard let self = self else { return }
                guard let index = indexes as? [Int] else { return }
                                                
                switch id{
                    case 0:
                        DispatchQueue.main.async {
                            self.fromView.button.setTitle(self.dizi[index[0]], for: .normal)
                            
                        }
                    case 1:
                        DispatchQueue.main.async {
                            self.toView.button.setTitle(self.dizi[index[0]], for: .normal)
                            
                        }
                    default:
                        break
                }
                                                
                return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: self.view)
    }
}

extension BusViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 45
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KoltukCell.identifier, for: indexPath) as! KoltukCell
        if boughtArray.contains(indexPath.row){
            cell.isUserInteractionEnabled = false
            cell.imageView.image = Images.notEmpty
        }
        else if(rezervasyonArray.contains(indexPath.row)){
            cell.imageView.image = Images.reserve
            cell.isUserInteractionEnabled = false
        }
        cell.number.text = String(indexPath.row+1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! KoltukCell
        index = indexPath
        print(index)
        print(rezervasyonArray)
        if selectedArray.contains(index.row){
            cell.imageView.image = Images.empty
            selectedArray.remove(at: selectedArray.firstIndex(of: index.row)!)
            
        }
        
        else{
            let vc = UserInfoView()
            vc.modalPresentationStyle = .overFullScreen
            vc.alertDelegate = self
            //vc.index = index.row
            cell.imageView.image = Images.selected
            
            selectedArray.append(index.row)
            present(vc, animated: true)
        }
    }
    
}

extension BusViewController: AlertDelegate{
    
    func okButtonClicked(_ yolcu: Yolcu) {
        
        let gun = String(self.date.prefix(2))
        let ay = String(self.date.prefix(5).suffix(2))
        let yil = String(self.date.suffix(4))
        
        let saat = String(hours.prefix(2))
        let dakika = String(hours.suffix(2))
        
        print("\(gun)/\(ay)/\(yil) \(saat):\(dakika)")
        
        bilet = Bilet(yolcu: yolcu, tarih: Tarih(gun: gun, ay: ay, yil: yil), saat: Saat(saat: saat, dakika: dakika), koltuk: index.row)
        satinAlinacak.append(bilet)
        bilet.yazdir()
    }
    
    func cancelButtonClicked() {
        let cell = collectionView.cellForItem(at: index) as! KoltukCell
        cell.imageView.image = Images.empty
    }
    
    
}

