//
//  PaymentModel.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 2/1/2562 BE.
//  Copyright © 2562 ONaJa. All rights reserved.
//

import Foundation
import UIKit

class PaymentM: NSObject {
    var paymentIMG: UIImage?
    var paymentType: String?
    var paymentDc: String?
    var subpayment: [SubPaymentM]!
    
    init(paymentIMG: UIImage, paymentType: String, paymentDc: String ,subpayment:[SubPaymentM]){
        self.paymentIMG = paymentIMG
        self.paymentType = paymentType
        self.paymentDc = paymentDc
        self.subpayment = subpayment
    }
}

class SubPaymentM: NSObject{
    var sPaymentIMG: UIImage?
    var sPaymentType: String?
    var sPaymentDc: String?
    init(sPaymentIMG:UIImage,sPaymentType:String,sPaymentDc:String){
        self.sPaymentIMG = sPaymentIMG
        self.sPaymentType = sPaymentType
        self.sPaymentDc = sPaymentDc
    }
    
}
