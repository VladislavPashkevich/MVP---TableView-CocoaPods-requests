

import Foundation
import UIKit

extension UIImage {
    func toString() -> String? {

        let pngData = self.pngData()

        return pngData?.base64EncodedString(options: .lineLength64Characters)
    }
    
    
}
