//
//  NotificationListenerVC.swift
//  Week-3
//
//  Created by Egemen Inceler on 9.07.2021.
//

import UIKit

class NotificationListenerVC: UIViewController {

    @IBOutlet weak var notificationDataLbl: UILabel!
    @IBOutlet weak var listenerImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let notificationCenter: NotificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(handleData(notification:)), name: .sendDataNotification, object: nil)
    }
    
    @objc func changeImage() {
        self.listenerImg.image = UIImage(named: "photo-4")
    }
    
    @objc func handleData(notification: Notification) {
        
        if let name = notification.userInfo?["name"] as? String {
            notificationDataLbl.text = name
        }
    }

}

