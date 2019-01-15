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
    
    var isGraphShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        }
        isGraphShowing = !isGraphShowing
    }
}
