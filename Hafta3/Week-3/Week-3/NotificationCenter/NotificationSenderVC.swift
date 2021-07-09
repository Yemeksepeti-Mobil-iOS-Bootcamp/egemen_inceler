//
//  NotificationSenderVC.swift
//  Week-3
//
//  Created by Egemen Inceler on 9.07.2021.
//

import UIKit

class NotificationSenderVC: UIViewController {

    @IBOutlet weak var textField: UITextField!
    var notificationData: [String: Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //MARK: Gönderilecek Data Kullanıcıdan Alınsın...
    //MARK: frame vs bound farkı nedir? Açıklayınız..

    @IBAction func sendNotificationBtn(_ sender: Any) {
        
        guard let text = textField.text else { return }
        notificationData["name"] = text
        
        NotificationCenter.default.post(name: .sendDataNotification, object: nil, userInfo: notificationData)
        dismiss(animated: true, completion: nil)
    }
    
}
