//
//  GraphView.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 14/1/2562 BE.
//  Copyright © 2562 ONaJa. All rights reserved.
//

import UIKit

@IBDesignable class GraphView: UIView {
    
    // 1
    @IBInspectable var startColor: UIColor =  UIColor(red: 250, green: 233, blue: 222)
    @IBInspectable var endColor: UIColor = UIColor(red: 252, green: 79, blue: 8)
    
    var graphPoints = [4,2,6,5,3,1,8]
    
    override func draw(_ rect: CGRect) {
        
        let width = rect.width
        let height = rect.height
        
        
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: .allCorners,
                                cornerRadii: Constants.cornerRadiusSize)
        path.addClip()
        // 2
        let context = UIGraphicsGetCurrentContext()!
        let colors = [startColor.cgColor, endColor.cgColor]
        
        // 3
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // 4
        let colorLocations: [CGFloat] = [0.0, 1.0]
        
        // 5
        let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors: colors as CFArray,
                                  locations: colorLocations)!
        
        // 6
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: 0, y: bounds.height)
        context.drawLinearGradient(gradient,
                                   start: startPoint,
                                   end: endPoint,
                                   options: [])
        
        //calculate the x point
        
        let margin = Constants.margin
        let graphWidth = width - margin * 2 - 4
        let columnXpoint = { (column: Int)  -> CGFloat in
        
        let spacing = graphWidth / CGFloat(self.graphPoints.count - 1)
        return CGFloat(column) * spacing + margin + 2
        }
        //calculate the y point
            
        let topBorder = Constants.topBorder
        let bottomBorder = Constants.bottomBorder
        let graphHeight = height - topBorder - bottomBorder
        let maxValue = graphPoints.max()!
        let columnYPoint = { (graphPoint: Int) -> CGFloat in
            let y = CGFloat(graphPoint) / CGFloat(maxValue) * graphHeight
            return graphHeight + topBorder - y //Flip the graph
            
            }
        
        UIColor.white.setFill()
        UIColor.white.setStroke()
        
        //set up the points line
        let graphPath = UIBezierPath()
        
        //go to start of line
        graphPath.move(to: CGPoint(x: columnXpoint(0),
                                   y: columnYPoint(graphPoints[0])))
        
        for i in 1..<graphPoints.count {
            let nextPoint = CGPoint(x: columnXpoint(i), y: columnYPoint(graphPoints[i]))
            graphPath.addLine(to: nextPoint)
        }
        
        graphPath.stroke()
        
        //Create the clipping path for the graph  gradient
        
        //2 - make a copy of the path
        let clippingPath = graphPath.copy() as! UIBezierPath
        
        //3 - add lines to the copied path to complete the clip area
        clippingPath.addLine(to: CGPoint(x: columnXpoint(graphPoints.count - 1 ),
                                         y: height))
        clippingPath.addLine(to: CGPoint(x: columnXpoint(0),
                                         y: height))
        clippingPath.close()
        
        clippingPath.addClip()
        
//        UIColor.green.setFill()
//        let rectPath = UIBezierPath(rect: rect)
//        rectPath.fill()
        
        let highestYPoint = columnYPoint(maxValue)
        let graphStartPoint = CGPoint(x: margin,
                                      y: highestYPoint)
        let graphEndPoint = CGPoint(x: margin,
                                    y: bounds.height)
        
        context.drawLinearGradient(gradient,
                                   start: graphStartPoint,
                                   end: graphEndPoint,
                                   options: [])
        
        graphPath.lineWidth = 2.0
        graphPath.stroke()
    
    }
    
    private struct Constants {
        static let cornerRadiusSize = CGSize(width: 8.0, height: 8.0)
        static let margin: CGFloat = 20.0
        static let topBorder: CGFloat = 60
        static let bottomBorder: CGFloat = 50
        static let colorAlpha: CGFloat = 0.3
        static let cicleDiameter: CGFloat = 5.0
    }
}
