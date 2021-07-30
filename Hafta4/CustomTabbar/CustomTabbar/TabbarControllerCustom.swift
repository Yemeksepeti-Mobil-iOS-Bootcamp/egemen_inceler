//
//  CustomTabbar.swift
//  CustomTabbar
//
//  Created by Egemen Inceler on 28.07.2021.
//

import UIKit


class TabbarControllerCustom: UITabBarController, UITabBarControllerDelegate {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.selectedIndex = 1
        tabBarConfig()
        setupMiddleButton()
        
        viewControllers = [configureSearchVC(), configureHomeVC(), configureProfileVC()]
    }
    
    private func tabBarConfig() {
        self.tabBar.barTintColor = .gray
        self.tabBar.tintColor = .white
        self.tabBar.unselectedItemTintColor = .black
    }
    
    func setupMiddleButton() {
        let middleButton = UIButton(frame: CGRect(x: (self.view.bounds.width/2) - 30, y: -25, width: 60, height: 60))
        middleButton.layer.cornerRadius = 10
        
        middleButton.setBackgroundImage(UIImage(systemName: "house"), for: .normal)
        middleButton.tintColor = .gray
        middleButton.backgroundColor = .lightGray
        self.tabBar.addSubview(middleButton)
    
        self.view.layoutIfNeeded()
    }
    

    
    private func configureSearchVC() -> UIViewController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return searchVC
    }
    
    private func configureHomeVC() -> UIViewController {
        let homeVC = HomeVC()
        
        
        return homeVC
    }
    
    private func configureProfileVC() -> UIViewController {
        let profileVC = ProfileVC()
        profileVC.title = "Profile"
        profileVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 2)
        return profileVC
    }
    
    
}
