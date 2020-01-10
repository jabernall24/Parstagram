//
//  UIViewController+Ext.swift
//  Parstagram
//
//  Created by Jesus Andres Bernal Lopez on 1/10/20.
//  Copyright © 2020 Jesus Bernal Lopez. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func performOkayAlertWith(title: String, message: String = "") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "Ok", style: .cancel)
        
        alert.addAction(okBtn)
        self.present(alert, animated: true)
    }

}
