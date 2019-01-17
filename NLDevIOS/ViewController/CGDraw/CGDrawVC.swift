//
//  CGDrawVC.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 14/1/2562 BE.
//  Copyright © 2562 ONaJa. All rights reserved.
//

import UIKit

class CGDrawVC: UIViewController {
    
    @IBOutlet weak var contView: UIView!
    @IBOutlet weak var graphView: GraphView!
    
    @IBOutlet weak var counterView: CounterView!
    @IBOutlet weak var lb_counter: UILabel!
    @IBOutlet weak var lb_Max: UILabel!
    
    @IBOutlet weak var lb_AVGwaterDrunk: UILabel!
    @IBOutlet weak var img_S: UIImageView!
    
    @IBOutlet weak var stackView: UIStackView!
    
    var isGraphShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkTotal()
        // Do any additional setup after loading the view.
    }
    


    @IBAction func pressPushBtn(_ button: PushButton) {
        if button.isAddButton && counterView.counter < 8 {
            counterView.counter += 1
        } else {
            if counterView.counter > 0 && counterView.counter <= 8{
            counterView.counter -= 1
            }
        }
        
        lb_counter.text = String(counterView.counter)
        if isGraphShowing{
            counterViewTap(nil)
        }
        checkTotal()
    }
    
    @IBAction func counterViewTap(_ gesture: UITapGestureRecognizer?){
        if (isGraphShowing){
            
            UIView.transition(from: graphView,
                              to: counterView,
                              duration: 1.0,
                              options: [.transitionFlipFromLeft,.showHideTransitionViews],
                              completion: nil)
        }else{
            
            UIView.transition(from: counterView,
                              to: graphView,
                              duration: 1.0,
                              options: [.transitionFlipFromRight,.showHideTransitionViews],
                              completion: nil)
                              setupGraphDisplay()
        }
        isGraphShowing = !isGraphShowing
    }
    
    func setupGraphDisplay(){
        
        let maxDayIndex = stackView.arrangedSubviews.count - 1
        
        graphView.graphPoints[graphView.graphPoints.count - 1] = counterView.counter
        
        graphView.setNeedsDisplay()
        lb_Max.text = "\(graphView.graphPoints.max()!)"
        
        let average = graphView.graphPoints.reduce(0, +) / graphView.graphPoints.count
        lb_AVGwaterDrunk.text = "\(average)"
        
        let today = Date()
        let calendar = Calendar.current
        
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("EEEEE")
        
        for i in 0...maxDayIndex {
            if let date = calendar.date(byAdding: .day,value: -i,to: today),
            let label = stackView.arrangedSubviews[maxDayIndex - i] as? UILabel {
                label.text = formatter.string(from: date)
            }
        }
        
        
    }
    func checkTotal(){
        if counterView.counter >= 8 {
            img_S.isHidden = false
        } else {
            img_S.isHidden = true
        }
    }
}
