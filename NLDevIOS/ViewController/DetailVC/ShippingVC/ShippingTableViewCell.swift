//
//  ShippingTableViewCell.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 27/12/2561 BE.
//  Copyright © 2561 ONaJa. All rights reserved.
//

import UIKit

class ShippingTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var shipBtn: UIButton!
    @IBOutlet weak var shipImg: UIImageView!
    
    @IBOutlet weak var shipNamelbl: UILabel!
    @IBOutlet weak var shipDatelbl: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
