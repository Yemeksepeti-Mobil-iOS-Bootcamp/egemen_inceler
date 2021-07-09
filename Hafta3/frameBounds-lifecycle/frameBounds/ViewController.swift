/*
 application:willFinishLaunchingWithOptions --> Uygulama başarılı bir şekilde ayağa kaldırılırsa ilk çalışacak AppDelegate fonksiyonudur.

 application:didFinishLaunchingWithOptions --> Uygulamadaki ilk ekran gelmeden çalıştırılacak SceneDelegate fonksiyonudur.

 viewDidLoad         --> UIViewController’ın lifecycle’inda sadece bir kez çağırılır.
 viewWillAppear    --> UIViewController her görünmeden önce çalışır.
 viewDidAppear     --> UIViewController her görüntülendiğinde çalışır.
 viewWillDisappear     --> UIViewController ekrandan kaybolmadan önce çalışır.
 viewDidDisappear     --> UIViewController ekrandan kaybolduktan hemen sonra çalışır.
 */

import UIKit

class ViewController: UIViewController {
    /*
     Frame -> view'ın bulunduğu superView'a göre konumudur. Bu örneğimiz için ana view ViewController.view'dır.
     Bounds -> View'ın kendi sınırları.
     
     Hiyerarşi olarak view -> subView1 -> subView2 olarak gitmekte.
     subView1'e frame verdiğimizde main view'a göre konum vermiş oluyoruz. Bu örnek için x:50, y:50 başlangıç noktası oluyor.
     subView2'e frame verdiğimizde ise x:10, y:10 vermemize rağmen subView1'in alt view'ı olduğu için subView1'in sınırları içirisinde
     x:10, y:10 konumuna yerleşiyor.
     */
    lazy var subView1 = UIView()
    lazy var subView2 = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .green
        configureSubView()
    }
    
    func configureSubView(){
        view.addSubview(subView1)
        subView1.addSubview(subView2)
         
        subView1.backgroundColor = .red
        subView2.backgroundColor = .blue
    }
    override func viewDidLayoutSubviews() {
        subView1.frame = CGRect(x: 50, y: 50, width: 200, height: 200)
        subView2.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
    }
}

