//
//  AutoTableVC.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 24/1/2562 BE.
//  Copyright © 2562 ONaJa. All rights reserved.
//

import Foundation
import UIKit

extension AutomaticVC : UITableViewDelegate, UITableViewDataSource {

//    let auteur: = ["","","",""]
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
        ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "autocell",
            for: indexPath) as! AutoTableViewCell

        cell.lb_text.text = auteurs[indexPath.row]
        cell.lb_text.textColor = UIColor(red:0.75, green:0.75, blue:0.75, alpha:1.0)
        return cell
    }
  
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return auteurs.count
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 200
//    }
    
    
}
