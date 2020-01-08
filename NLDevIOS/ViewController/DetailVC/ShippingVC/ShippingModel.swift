//
//  ShippingModel.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 27/12/2561 BE.
//  Copyright © 2561 ONaJa. All rights reserved.
//

import Foundation
import UIKit

class ShippingM: NSObject {
    var shipIMG: UIImage?
    var shipName: String?
    var shipDate: String?
    
    init(shipIMG: UIImage, shipName: String, shipDate: String ){
        self.shipIMG = shipIMG
        self.shipName = shipName
        self.shipDate = shipDate
    }
}
