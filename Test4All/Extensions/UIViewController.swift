//
//  UIViewController.swift
//  Test4All
//
//  Created by George Gomes on 10/07/19.
//  Copyright © 2019 George Gomes. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func alertMessage(_ message: String, action: ((UIAlertAction) -> Void)?, with cancel: Bool = false) {
        
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        if cancel {
            let cancelButton = UIAlertAction(title: "cancelar", style: .default, handler: nil)
            alertController.addAction(cancelButton)
        }
        
        let actionOk = UIAlertAction(title: "Ok", style: .default, handler: action)
        alertController.addAction(actionOk)
        
        
        
        present(alertController, animated: true, completion: nil)
    }
}
