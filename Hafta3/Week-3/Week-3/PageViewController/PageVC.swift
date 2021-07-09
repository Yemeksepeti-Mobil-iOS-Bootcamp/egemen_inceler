//
//  PageVC.swift
//  Week-3
//
//  Created by Egemen Inceler on 5.07.2021.
//

import UIKit

class PageVC: UIPageViewController {
    var view1 = UIView()
    var controllers = [UIViewController]()
    override func viewDidLoad() {
        super.viewDidLoad()

        let vc1 = UIViewController()
        vc1.view.backgroundColor = .red
        controllers.append(vc1)
        
        let vc2 = UIViewController()
        vc2.view.backgroundColor = .green
        controllers.append(vc2)
        
        let vc3 = UIViewController()
        vc3.view.backgroundColor = .blue
        controllers.append(vc3)
        
        configureSubView()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.pageVC()
    }
    func configureSubView(){
        view.addSubview(view1)
        view1.backgroundColor = .black
        view1.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view1.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            view1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            view1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            view1.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    func pageVC() {
        guard let first = controllers.first else { return }
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        vc.delegate = self
        vc.dataSource = self
        vc.setViewControllers([first], direction: .forward, animated: true, completion: nil)
        //vc.modalPresentationStyle = .fullScreen
        view1.addSubview(vc.view)
        //present(vc, animated: true, completion: nil)
        
    }


}
extension PageVC: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = controllers.firstIndex(of: viewController), index > 0 else { return nil }
        
        let prev = index - 1
        
        return controllers[prev]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let index = controllers.firstIndex(of: viewController), index < (controllers.count - 1) else { return nil }
        
        let next = index + 1
        
        return controllers[next]
    }
    
    
}
