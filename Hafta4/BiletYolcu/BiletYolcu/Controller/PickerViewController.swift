//
//  PickerViewController.swift
//  BiletYolcu
//
//  Created by Egemen Inceler on 23.07.2021.
//

import UIKit

enum PickerType{
    case date, location
}

class PickerViewController: UIViewController {
    
    var dataArray: [String] = ["Tekirdağ", "İstanbul", "Yeniçiftlik", "Marmaraereğlisi"]
    var type: PickerType?
    let pickerLocation = UIPickerView()
    let pickerDate     = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setType(self.type!)
        
    }
    
    init(by type: PickerType){
        super.init(nibName: nil, bundle: nil)
        self.type = type
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setType(_ type: PickerType){
        switch type {
        case .date:
            view.addSubview(pickerDate)
            pickerDate.timeZone = TimeZone.current
            pickerDate.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        case .location:
            view.addSubview(pickerLocation)
            pickerLocation.dataSource = self
            pickerLocation.delegate   = self
        }
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        let selectedDate: String = dateFormatter.string(from: sender.date)
        print("Selected value \(selectedDate)")
    }
}

extension PickerViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataArray[row]
    }
}
