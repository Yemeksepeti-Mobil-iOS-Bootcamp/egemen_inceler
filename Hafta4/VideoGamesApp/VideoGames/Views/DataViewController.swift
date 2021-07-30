import UIKit
import Kingfisher

class DataViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image: String? {
        didSet{
            self.imageView?.kf.setImage(with: URL(string: image!))
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let img = image {
            self.imageView?.kf.setImage(with: URL(string: img))
        }
    }
}
