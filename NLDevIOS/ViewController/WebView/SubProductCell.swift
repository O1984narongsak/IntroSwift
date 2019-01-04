//
//  SubProductCell.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 4/1/2562 BE.
//  Copyright © 2562 ONaJa. All rights reserved.
//

import UIKit

class SubProductCell: UITableViewCell {

    @IBOutlet weak var lb_SubType: UILabel!
    @IBOutlet weak var lb_SubDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
