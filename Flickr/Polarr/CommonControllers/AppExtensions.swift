//
//  AppExtensions.swift
//  Polarr
//
//  Created by Muzammil Mohammad on 18/08/20.
//  Copyright © 2020 Turing. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    var topbarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}

extension UIApplication {
    var keyWindowInConnectedScenes: UIWindow? {
        return windows.first(where: { $0.isKeyWindow })
    }
}

extension UIView {

    var screenWidth: CGFloat {
         
        let screenRect = UIScreen.main.bounds
        let width = screenRect.size.width
        return width
    }
    
    var screenHeight: CGFloat {
         
        let screenRect = UIScreen.main.bounds
        let height = screenRect.size.height
        return height
    }
    
    var safeAreaBottom: CGFloat {
         if #available(iOS 11, *) {
            if let window = UIApplication.shared.keyWindowInConnectedScenes {
                return window.safeAreaInsets.bottom
            }
         }
         return 0
    }

    var safeAreaTop: CGFloat {
         if #available(iOS 11, *) {
            if let window = UIApplication.shared.keyWindowInConnectedScenes {
                return window.safeAreaInsets.top
            }
         }
         return 0
    }
}

extension UIColor {
    
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
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
    
    func randomColor() -> UIColor{
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

extension UIFont
{
    struct AppFonts
    {
        static func RobotoMedium(size: CGFloat) -> UIFont
        {
            return UIFont(name: "Roboto-Medium", size: size)!
        }
        static func RobotoRegular(size: CGFloat) -> UIFont
        {
            return UIFont(name: "Roboto-Regular", size: size)!
        }
        static func RobotoThin(size: CGFloat) -> UIFont
        {
            return UIFont(name: "Roboto-Thin", size: size)!
        }
        static func RobotoMonoMedium(size: CGFloat) -> UIFont
        {
            return UIFont(name: "RobotoMono-Medium", size: size)!
        }
        static func RobotoMonoLight(size: CGFloat) -> UIFont
        {
            return UIFont(name: "RobotoMono-Light", size: size)!
        }
        static func RobotoMonoRegular(size: CGFloat) -> UIFont
        {
            return UIFont(name: "RobotoMono-Regular", size: size)!
        }
        static func RobotoMonoThin(size: CGFloat) -> UIFont
        {
            return UIFont(name: "RobotoMono-Thin", size: size)!
        }
    }
}

var hasTopNotch: Bool {
    if #available(iOS 11.0,  *) {
        return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
    }
    return false
}

extension UIDevice {
    
    var iPhone11: Bool {
        return UIScreen.main.nativeBounds.height == 1792 ||  UIScreen.main.nativeBounds.height > 1792
    }
    
    var iPhoneX: Bool {
        return UIScreen.main.nativeBounds.height == 2436 ||  UIScreen.main.nativeBounds.height > 2436
    }
    
    var iPhone5: Bool {
        return UIScreen.main.nativeBounds.height == 1136
    }
    
    var iPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    var iPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    enum ScreenType: String {
        case iPhones_4_4S = "iPhone 4 or iPhone 4S"
        case iPhones_5_5s_5c_SE = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
        case iPhones_6_6s_7_8 = "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
        case iPhones_6Plus_6sPlus_7Plus_8Plus = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus"
        case iPhones_X_XS = "iPhone X or iPhone XS"
        case iPhone_XR = "iPhone XR"
        case iPhone_XSMax = "iPhone XS Max"
        case unknown
    }
    var screenType: ScreenType {
        switch UIScreen.main.nativeBounds.height {
        case 960:
            return .iPhones_4_4S
        case 1136:
            return .iPhones_5_5s_5c_SE
        case 1334:
            return .iPhones_6_6s_7_8
        case 1792:
            return .iPhone_XR
        case 1920, 2208:
            return .iPhones_6Plus_6sPlus_7Plus_8Plus
        case 2436:
            return .iPhones_X_XS
        case 2688:
            return .iPhone_XSMax
        default:
            return .unknown
        }
    }
}

func toString(_ value: Any?) -> String {
  return String(describing: value ?? "")
}
