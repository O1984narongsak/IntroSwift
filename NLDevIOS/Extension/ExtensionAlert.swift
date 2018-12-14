//
//  ExtensionAlert.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 12/12/2561 BE.
//  Copyright © 2561 ONaJa. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func presentAlertWithTitle(title: String, message: String, completion: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (action) in
                completion()
            }))
        self.present(alertController, animated: true, completion: nil)
    }
}
