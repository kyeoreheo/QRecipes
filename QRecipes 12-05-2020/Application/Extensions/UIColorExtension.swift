//
//  UIColorExtension.swift
//  QRecipes
//
//  Created by Kyo on 9/14/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit

extension UIColor {
    static let primeOrange = UIColor(hexString: "#FF922B")
    static let cherryRed = UIColor(hexString: "#D21404")
    static let pumpkinRed = UIColor(hexString: "#F4511E")
    static let facebookBlue = UIColor(hexString: "#3B5998")
    static let lightlightGray = UIColor(hexString: "#D3D3D3")
    static let backgroundGray = UIColor(hexString: "#F5F5F5")
    static let charcoalBlack = UIColor(hexString: "#424242")
    static let fbColor = UIColor(hexString: "#1877F2")
    
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
          let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
          let scanner = Scanner(string: hexString)
          if (hexString.hasPrefix("#")) {
              scanner.scanLocation = 1
          }
          var color: UInt32 = 0
          scanner.scanHexInt32(&color)
          let mask = 0x000000FF
          let r = Int(color >> 16) & mask
          let g = Int(color >> 8) & mask
          let b = Int(color) & mask
          let red   = CGFloat(r) / 255.0
          let green = CGFloat(g) / 255.0
          let blue  = CGFloat(b) / 255.0
          self.init(red:red, green:green, blue:blue, alpha:alpha)
      }
}

extension UIImage {
    func scaledDown(into size:CGSize, centered:Bool = false) -> UIImage {
        var (targetWidth, targetHeight) = (self.size.width, self.size.height)
        var (scaleW, scaleH) = (1 as CGFloat, 1 as CGFloat)
        if targetWidth > size.width {
            scaleW = size.width/targetWidth
        }
        if targetHeight > size.height {
            scaleH = size.height/targetHeight
        }
        let scale = min(scaleW,scaleH)
        targetWidth *= scale; targetHeight *= scale
        let sz = CGSize(width:targetWidth, height:targetHeight)
        if !centered {
            return UIGraphicsImageRenderer(size:sz).image { _ in
                self.draw(in:CGRect(origin:.zero, size:sz))
            }
        }
        let x = (size.width - targetWidth)/2
        let y = (size.height - targetHeight)/2
        let origin = CGPoint(x:x,y:y)
        return UIGraphicsImageRenderer(size:size).image { _ in
            self.draw(in:CGRect(origin:origin, size:sz))
        }
    }
}
