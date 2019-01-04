//
//  DataCenter.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 27/12/2561 BE.
//  Copyright © 2561 ONaJa. All rights reserved.
//

import Foundation

class Shipping {
    var _shippingflow: ShippingM?

    class var sharedInstance: Shipping {
        struct Static {
            static let instance = Shipping()
        }
        return Static.instance
    }
}
