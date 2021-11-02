
import UIKit

extension UIView {
    // MARK: Shadow
    @IBInspectable var shadowOffset: CGSize  {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowColor: UIColor {
        get {
            if let cgColor = self.layer.shadowColor {
                return UIColor(cgColor: cgColor)
            } else {
                return .clear
            }
        }
        set {
            self.layer.shadowColor = newValue.cgColor
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
    
    
    // MARK: Round
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    func roundCorners (_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.frame = bounds
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    // MARK: Border
    @IBInspectable var borderWidth: CGFloat {
            get {
                return self.layer.borderWidth
            }
            set {
                self.layer.borderWidth = newValue
            }
        }
        
        @IBInspectable var borderColor: UIColor? {
            get {
                if let cgColor = self.layer.borderColor {
                    return UIColor(cgColor: cgColor)
                }
                return nil
            }
            set {
                if let cgColor = newValue {
                    self.layer.borderColor = cgColor.cgColor
                } else {
                    self.layer.borderColor = nil
                }
            }
        }
  


    
}




