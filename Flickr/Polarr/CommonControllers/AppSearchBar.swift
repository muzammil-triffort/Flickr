//
//  AppSearchBar.swift
//  Polarr
//
//  Created by Muzammil Mohammad on 18/08/20.
//  Copyright © 2020 Turing. All rights reserved.
//

import Foundation
import UIKit

protocol AppSearchBarDelegate {
    
    func appSearchViewSearchButtonTapped()
    func appSearchViewSearchText(searchText: NSString)
}

class AppSearchBar : UIView, UITextFieldDelegate {

    @IBOutlet var textField: UITextField!
    @IBOutlet var crossButton: UIButton!

    var delegate: AppSearchBarDelegate?
    
    override func layoutSubviews() {

        self.textField.delegate     = self
        self.crossButton.isHidden   = true
        self.textField.placeholder  = "Search keyword"
        self.crossButton.addTarget(self, action: #selector(self.crossButtonAction), for: .touchUpInside)
    }
    
    @objc func crossButtonAction() {
        self.textField.text = ""
    }
       
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.crossButton.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.crossButton.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.textField.resignFirstResponder()
        
        if self.delegate != nil {
            self.delegate?.appSearchViewSearchText(searchText: textField.text! as NSString)
            self.delegate?.appSearchViewSearchButtonTapped()
        }
        
        return true
    }
}
