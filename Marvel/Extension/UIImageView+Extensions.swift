//
//  UIImageView+Extensions.swift
//  Marvel
//
//  Created by Rabi Chourasia on 10/03/22.
//

import SDWebImage
import UIKit

extension UIImageView {
    
    func setImage(_ url: URL?) {
        self.sd_setImage(with: url, completed: nil)
    }
    
}
extension String
{
    func encodeUrl() -> String
    {
        return self.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)!
    }
    
}
extension UIImage {
    
    func resizeImage(s: CGSize) -> UIImage? {
        let horizontalRatio = s.width / size.width
        let verticalRatio = s.height / size.height
        let ratio = max(horizontalRatio, verticalRatio)
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
        draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
