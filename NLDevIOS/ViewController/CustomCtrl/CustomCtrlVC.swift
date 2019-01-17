//
//  CustomCtrl.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 15/1/2562 BE.
//  Copyright © 2562 ONaJa. All rights reserved.
//

import UIKit

class CustomCtrlVC: UIViewController {

    @IBOutlet weak var valueSlider: UISlider!
    @IBOutlet weak var lb_value: UILabel!
    @IBOutlet var knob: Knob!
    @IBOutlet var btn_handle: UIButton!
    
    @IBOutlet var animateSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        knob.lineWidth = 4
        knob.pointerLength = 12
        knob.addTarget(self, action: #selector(CustomCtrlVC.handleValueChanged(_:)), for: .valueChanged)
    }
    
    @IBAction func handleValueChanged(_ sender: Any) {
        if sender is UISlider {
            knob.setValue(valueSlider.value)
        } else {
            valueSlider.value = knob.value
        }
        
        updateLabel()
        
    }
    
    @IBAction func handleBtnPressed(_ sender: Any) {
        
        let randomValue = Float(arc4random_uniform(101)) / 100.0
        knob.setValue(randomValue, animated: animateSwitch.isOn)
        updateLabel()
    }
    
    func updateLabel(){
        lb_value.text = String(format: "%.2f", knob.value)
    }
    
}



