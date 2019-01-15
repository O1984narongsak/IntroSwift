//
//  SlidesVC.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 14/1/2562 BE.
//  Copyright © 2562 ONaJa. All rights reserved.
//

import UIKit

class SlidesVC: UIViewController {
    
    var seconds = 55
    var timer = Timer()

    @IBOutlet weak var lb_time: UILabel!
    
    @IBOutlet weak var sl_slide: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


    @IBAction func pressSliders(_ sender: UISlider) {
        seconds = Int(sender.value)
      setLabel()
    }
    
    
    @IBAction func pressStartBtn(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(SlidesVC.updateTimer), userInfo: nil, repeats: true)
    }
    
    @IBAction func pressStopBtn(_ sender: Any) {
        timer.invalidate()
//        seconds = 0
//        sl_slide.setValue(0, animated: true)
        setLabel()
    }
    
    @objc func updateTimer(){
        
        seconds -= 1
        setLabel()
        
        sl_slide.value = Float(seconds)
        
        if seconds == 0 {
            timer.invalidate()
        }
        
    }
    
    func setLabel(){
        lb_time.text = timeString(time: TimeInterval(seconds))
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
   
        return String(format:"%02i:%02i:%02i" ,hours,minutes,seconds)
    }
}
