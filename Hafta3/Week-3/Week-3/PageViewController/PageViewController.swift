//
//  PageViewController.swift
//  Week-3
//
//  Created by Kerim Caglar on 4.07.2021.
//

import UIKit

class PageViewController: UIPageViewController {
    
    var controllers = [UIViewController]()
    var pageControl = UIPageControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        let vc1 = UIViewController()
        let imageView = UIImageView(image: UIImage(named: "onboarding1"))
        imageView.frame = CGRect(x: 0, y: 100, width: vc1.view.bounds.width, height: vc1.view.bounds.height/2)
        vc1.view.backgroundColor = .white
        vc1.view.addSubview(imageView)
        controllers.append(vc1)
        
        let vc2 = UIViewController()
        let imageView2 = UIImageView(image: UIImage(named: "onboarding2"))
        imageView2.frame = CGRect(x: 0, y: 100, width: vc2.view.bounds.width, height: vc1.view.bounds.height/2)
        vc2.view.backgroundColor = .white
        vc2.view.addSubview(imageView2)
        controllers.append(vc2)
        
        let vc3 = UIViewController()
        let imageView3 = UIImageView(image: UIImage(named: "onboarding3"))
        imageView3.frame = CGRect(x: 0, y: 100, width: vc3.view.bounds.width, height: vc2.view.bounds.height/2)
        vc3.view.backgroundColor = .white
        vc3.view.addSubview(imageView3)
        controllers.append(vc3)
        
        pageControl.addTarget(self, action: #selector(pageControlClicked(_:)), for: .valueChanged)
        
    }
    @objc func pageControlClicked(_ sender: UIPageControl){
        setViewControllers([controllers[sender.currentPage]], direction: .forward, animated: true, completion: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.confugurePageView()
    }
    
    func confugurePageView() {
        guard let first = controllers.first else { return }
        
        delegate = self
        dataSource = self
        
        setViewControllers([first], direction: .forward, animated: true, completion: nil)
        
        configurePageControl()
        
    }
    
    func configurePageControl(){
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.numberOfPages = controllers.count
        pageControl.currentPage = 0
        
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    
}

extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = controllers.firstIndex(of: viewController), index > 0 else { return nil }
        
        let prev = index - 1
        pageControl.currentPage = prev
        return controllers[prev]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let index = controllers.firstIndex(of: viewController), index < (controllers.count - 1) else { return nil }
        
        let next = index + 1
        pageControl.currentPage = next
        return controllers[next]
    }
    
    
}

//MARK: PageControl ekleyerek bir onboarding ekranı yapınız..
