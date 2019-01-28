//
//  HomeTable.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 4/1/2562 BE.
//  Copyright © 2562 ONaJa. All rights reserved.
//

import UIKit

class HomeTable: UITableView {
    
    override func awakeFromNib() {
        self.delegate = self
        self.dataSource = self
    }

}

extension HomeTable: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        if row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeatureCell") as! FeatureCell
            
            return cell
        }else if row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell") as! TestCell
            cell.lb_model.text = "TESLA 3S"
            cell.lb_modeldesc.text = "thsi is good model of EV vehicle then mobilitie of transport of the the nest 21st Century and now that EV have prove the limitation of batterly type of litheam ,and now you will see it."
            return cell
            
        }else if row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SubProductCell") as! SubProductCell
            cell.lb_SubType.text = "Test:"
            cell.lb_SubDesc.text = "Make it Real"
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as! CategoryCell
            
            return cell
        }
    }
}
