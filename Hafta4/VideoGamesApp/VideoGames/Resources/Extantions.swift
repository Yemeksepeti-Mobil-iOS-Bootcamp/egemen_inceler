import UIKit

extension String{
    func fromHTML() -> NSAttributedString{
        
        let htmlData = NSString(string: self).data(using: String.Encoding.unicode.rawValue)
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        let attributedString = try! NSAttributedString(data: htmlData!, options: options, documentAttributes: nil)
        
        return attributedString
    }
}


extension UIView{
    public var width: CGFloat{
        return frame.size.width
    }
    
    public var height: CGFloat{
        return frame.size.height
    }
    
    public var top: CGFloat{
        return frame.origin.y
    }
    
    public var bottom: CGFloat{
        return frame.origin.y + frame.size.height
    }
    
    public var left: CGFloat{
        return frame.origin.x
    }
    
    public var right: CGFloat{
        return frame.origin.x + frame.size.width
    }
    public var middle: CGFloat{
        return frame.size.width/2
    }
}

extension UITextView {
    
    func centerVerticalText() {
        let fitSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fitSize)
        let calculate = (bounds.size.height - size.height * zoomScale) / 2
        let offset = max(1, calculate)
        contentOffset.y = -offset
    }
}

public extension UIView {
    
    func fadeIn(duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        })
    }
    
    func fadeOut(duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.5
        })
    }
}
