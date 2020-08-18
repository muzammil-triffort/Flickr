//
//  AppNavigationBar.swift
//  Polarr
//
//  Created by Muzammil Mohammad on 18/08/20.
//  Copyright © 2020 Turing. All rights reserved.
//

import Foundation
import UIKit

class AppNavigationBar : UINavigationController {
    
    override class func awakeFromNib() {
    }
    
    override func viewDidLoad() {
        
        self.navigationBar.backgroundColor = .white
        self.navigationBar.isTranslucent = false
        self.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        self.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
    
        self.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.layoutIfNeeded()
    }
}

extension UIViewController
{
    func showNavigationLine() {
        
        let width = self.view.frame.size.width - 30
        let y = (self.navigationController?.navigationBar.frame.size.height)! - 1
        let line = UILabel.init(frame: CGRect(x: 15, y: y, width: width, height: 1))
        line.backgroundColor = .black
        self.navigationController?.navigationBar.addSubview(line)
    }
    
    func setNavigationTitle(title: String)
    {
        let width = self.view.frame.size.width - 100
        
        let titleLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: width, height: 30))
        titleLabel.textColor = .black
        titleLabel.text = title
        titleLabel.textAlignment = .left
        titleLabel.backgroundColor = .clear
        titleLabel.font = UIFont.AppFonts.RobotoRegular(size: 19)
        self.navigationItem.titleView = titleLabel
    }
}
