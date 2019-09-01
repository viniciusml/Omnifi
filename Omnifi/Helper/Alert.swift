//
//  Alert.swift
//  StellaMcCartney
//
//  Created by Vinicius Leal on 31/08/19.
//  Copyright © 2019 Vinicius Leal. All rights reserved.
//

import Foundation
import UIKit

///Alert to handle possible connectivity issues.
class Alert {
    
    func showBasicAlert(title: String, message: String, vc: UIViewController) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        vc.present(alert, animated: true)
    }
}
