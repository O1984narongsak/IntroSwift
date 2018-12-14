//
//  SubWebVC.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 13/12/2561 BE.
//  Copyright © 2561 ONaJa. All rights reserved.
//

import UIKit

class SubWebVC: UIViewController {
    
    @IBOutlet weak var lblText: UILabel!
    
    var get_string = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabel()
        // Do any additional setup after loading the view.
    }
    
    func setLabel(){
        lblText.text = get_string
    }



}
