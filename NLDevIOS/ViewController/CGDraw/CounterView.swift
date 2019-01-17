//
//  CounterView.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 14/1/2562 BE.
//  Copyright © 2562 ONaJa. All rights reserved.
//

import UIKit

@IBDesignable class CounterView: UIView {

    private struct Constants {
        static let numberOFGlasses = 8
        static let lineWidth: CGFloat = 5.0
        static let arcWidth: CGFloat = 76
        
        static var halfOfLineWidth: CGFloat {
            return lineWidth / 2
        }
    }
    
    @IBInspectable var counter : Int = 5 {
        didSet {
            if counter <= Constants.numberOFGlasses {
                setNeedsDisplay()
            }
        }
    }
    @IBInspectable var outlineCOLOR: UIColor = UIColor(red: 34, green: 110, blue: 110)
    @IBInspectable var counterColor: UIColor = UIColor(red: 87, green: 218, blue: 123)
    
    override func draw(_ rect: CGRect) {
        
        let center = CGPoint(
            x: bounds.width / 2,
            y: bounds.height / 2)
        
        let radius: CGFloat = max(bounds.width, bounds.height)
        
        let startAngle: CGFloat = 3 * .pi / 4
        let endAngle: CGFloat = .pi / 4
        
        let path = UIBezierPath(arcCenter: center,
                                radius: radius/2 - Constants.arcWidth/2,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        
        path.lineWidth = Constants.arcWidth
        counterColor.setStroke()
        path.stroke()
        
        let angleDifference: CGFloat = 2 * .pi - startAngle + endAngle
        
        let arcLengthPerGlass = angleDifference / CGFloat(Constants.numberOFGlasses)
        
        let outlineEndAngle = arcLengthPerGlass * CGFloat(counter) + startAngle
        
        let outlinePath = UIBezierPath(arcCenter: center,
                                       radius: bounds.width/2 - Constants.halfOfLineWidth,
                                       startAngle: startAngle,
                                       endAngle: outlineEndAngle,
                                       clockwise: true)
        
        outlinePath.addArc(withCenter: center,
                           radius: bounds.width/2 - Constants.arcWidth + Constants.halfOfLineWidth,
                           startAngle: outlineEndAngle,
                           endAngle: startAngle,
                           clockwise: false)
        
        outlinePath.close()
        
        outlineCOLOR.setStroke()
        outlinePath.lineWidth = Constants.lineWidth
        outlinePath.stroke()
        
        let context = UIGraphicsGetCurrentContext()!
        
        //save original state
        context.saveGState()
        outlineCOLOR.setFill()
        
        let markerWidth: CGFloat = 5.0
        let markerSize: CGFloat = 10.0
        
        //move top left context to center position
        let markerPath = UIBezierPath(rect: CGRect(x: -markerWidth / 2,
                                                   y: 0,
                                                   width: markerWidth,
                                                   height: markerSize))
        
        context.translateBy(x: rect.width / 2 , y: rect.height / 2)
        
        for i in 1...Constants.numberOFGlasses {
            //csave the contre context
            context.saveGState()
            
            //calculate the rotation angle
            let angle = arcLengthPerGlass * CGFloat(i) + startAngle - .pi / 2
            
            context.rotate(by: angle)
            context.translateBy(x: 0, y: rect.height / 2 - markerSize)
            
            markerPath.fill()
            
            context.restoreGState()
        }
        
        context.restoreGState()
    }


}
