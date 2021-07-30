import UIKit

protocol CustomPageViewControllerDelegate: class {
    func setupPageController(numberOfPages: Int)
    func turnPageController(to index: Int)
}

class CustomPageViewController: UIPageViewController {
    weak var customPageViewControllerDelegate: CustomPageViewControllerDelegate?
    var images: [String]? = [""]
    
    lazy var controllers: [UIViewController] = {
        var controllers = [UIViewController]()
        if let images = self.images {
            for image in images{
                let dataVC = storyboard?.instantiateViewController(identifier: "DataViewController") as! DataViewController
                controllers.append(dataVC)
            }
        }
        self.customPageViewControllerDelegate?.setupPageController(numberOfPages: controllers.count)
        return controllers
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
    }
    
    func turnToPage(index: Int){
        let controller = controllers[index]
        var direction = UIPageViewController.NavigationDirection.forward
        if let currentVC = viewControllers?.first {
            let currentIndex = controllers.firstIndex(of: currentVC)
            if currentIndex! > index {
                direction = .reverse
            }
        }
        self.configureDisplaying(viewController: controller)
        setViewControllers([controller], direction: direction, animated: true, completion: nil)
    }
    func configureDisplaying(viewController: UIViewController){
        for (index, vc) in controllers.enumerated(){
            if viewController == vc {
                if let imageVC = viewController as? DataViewController {
                    imageVC.image = images?[index]
                }
                self.customPageViewControllerDelegate?.turnPageController(to: index)
            }
        }
    }
}

extension CustomPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = controllers.firstIndex(of: viewController){
            if index > 0 {
                return controllers[index-1]
            }
        }
        return controllers.last
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = controllers.firstIndex(of: viewController){
            if index < controllers.count-1 {
                return controllers[index+1]
            }
        }
        return controllers.first
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        self.configureDisplaying(viewController: pendingViewControllers.first as! DataViewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if !completed {
            self.configureDisplaying(viewController: previousViewControllers.first as! DataViewController)
        }
    }
}
