//
//  BGCGView.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 15/1/2562 BE.
//  Copyright © 2562 ONaJa. All rights reserved.
//

import UIKit

@IBDesignable
class BGCGView: UIView {

    @IBInspectable var lightColor: UIColor = UIColor(red: 255, green: 255, blue: 242)
    @IBInspectable var darkColor: UIColor = UIColor(red: 223, green: 255, blue: 247)
    @IBInspectable var patternSize: CGFloat = 30
    
    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()!
        
        context.setFillColor(darkColor.cgColor)
        
        context.fill(rect)
        
        let drawSize = CGSize(width: patternSize, height: patternSize)
        
        UIGraphicsBeginImageContextWithOptions(drawSize, true, 0.0)
        
        let drawingContext = UIGraphicsGetCurrentContext()!
        
        darkColor.setFill()
        
        drawingContext.fill(CGRect(x: 0, y: 0, width: drawSize.width, height: drawSize.height))
        
//        let drawSize = CGSize(width: patternSize, height: patternSize)
        
        let trianglePath = UIBezierPath()
        
        trianglePath.move(to: CGPoint(x: drawSize.width/2,
                                      y: 0))
        
        trianglePath.addLine(to: CGPoint(x: 0,
                                         y: drawSize.height/2))
        
        trianglePath.addLine(to: CGPoint(x: drawSize.width,
                                         y: drawSize.height/2))
        
        trianglePath.move(to: CGPoint(x: 0,
                                      y: drawSize.height/2))
        
        trianglePath.addLine(to: CGPoint(x: drawSize.width/2,
                                         y: drawSize.height))
        
        trianglePath.addLine(to: CGPoint(x: 0,
                                         y: drawSize.height))
        
        trianglePath.move(to: CGPoint(x: drawSize.width,
                                      y: drawSize.height/2))
        
        trianglePath.addLine(to: CGPoint(x: drawSize.width/2,
                                         y: drawSize.height))
        
        trianglePath.addLine(to: CGPoint(x: drawSize.width,
                                         y: drawSize.height))
        
        lightColor.setFill()
        trianglePath.fill()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        UIColor(patternImage: image).setFill()
        context.fill(rect)
        
    }

}
