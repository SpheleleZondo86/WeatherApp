//
//  Extensions.swift
//  WeatherApp
//
//  Created by Sphelele Zondo on 2018/07/30.
//  Copyright © 2018 SpheleleZondo. All rights reserved.
//

import Foundation
import UIKit

extension Double{
    func roundOff(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded()/divisor
    }
}

extension UIViewController{
    class func displaySpinner(onView:UIView)->UIView{
        let spinnerView = UIView.init(frame:onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red:0.5,green:0.5,blue:0.5,alpha:0.9)
        let activityIndicator = UIActivityIndicatorView.init(activityIndicatorStyle:.whiteLarge)
        activityIndicator.startAnimating()
        activityIndicator.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(activityIndicator)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner: UIView){
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension Date{
    func dayOfWeek()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
