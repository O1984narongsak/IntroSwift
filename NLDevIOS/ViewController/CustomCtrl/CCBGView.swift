//
//  CCBGView.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 15/1/2562 BE.
//  Copyright © 2562 ONaJa. All rights reserved.
//

import UIKit

@IBDesignable
class CCBGView: UIView {

    @IBInspectable var coolColor: UIColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    @IBInspectable var hotColor: UIColor = #colorLiteral(red: 0.720890411, green: 0.9473726455, blue: 1, alpha: 1)
    @IBInspectable var scaleSize: CGFloat = 30
    
    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()!
        
        context.setFillColor(coolColor.cgColor)
        
        context.fill(rect)
        
        let drawSize = CGSize(width: scaleSize, height: scaleSize)
        
        UIGraphicsBeginImageContextWithOptions(drawSize, true, 0.0)
        
        let drawContext = UIGraphicsGetCurrentContext()!
        
        coolColor.setFill()
        
        drawContext.fill(CGRect(x: 0, y: 0, width: drawSize.width, height: drawSize.height))
        
        let fiveangle = UIBezierPath()
        
        fiveangle.move(to: CGPoint(x: drawSize.width/2,
                                   y: 0))
        
        fiveangle.addLine(to: CGPoint(x: 0,
                                         y: drawSize.height/2))
        
        fiveangle.addLine(to: CGPoint(x: drawSize.width/4,
                                         y: drawSize.height))
        
        fiveangle.addLine(to: CGPoint(x: drawSize.width/2,
                                      y: drawSize.height * 3 / 4))
        
        fiveangle.addLine(to: CGPoint(x: drawSize.width * 3 / 4,
                                      y: drawSize.height))
        
        fiveangle.addLine(to: CGPoint(x: drawSize.width,
                                         y: drawSize.height/2))
        
        hotColor.setFill()
        fiveangle.fill()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        UIColor(patternImage: image).setFill()
        context.fill(rect)
        
    }


}
