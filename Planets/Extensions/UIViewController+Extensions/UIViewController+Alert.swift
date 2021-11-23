//
//  UIViewController+Alert.swift
//  Planets
//
//  Created by Esraa Mohamed Ragab on 23/11/2021.
//

import UIKit

extension UIViewController {
    
    func presentAlert(withTitle title:String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
}

