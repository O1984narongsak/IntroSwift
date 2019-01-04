//
//  ImageConstants.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 21/12/2561 BE.
//  Copyright © 2561 ONaJa. All rights reserved.
//



#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit.UIImage
typealias Image = UIImage
#elseif os(OSX)
import AppKit.NSImage
typealias Image = NSImage
#endif


enum Asset: String {

    case iconapp2 = "iconapp2"
    case cart = "cart"


    var image: Image {
        return Image(asset: self)
    }
}
// swiftlint:enable type_body_length

extension Image {
    convenience init!(asset: Asset) {
        self.init(named: asset.rawValue)
    }
}
