//
//  AutoTableViewCell.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 24/1/2562 BE.
//  Copyright © 2562 ONaJa. All rights reserved.
//

import UIKit

class AutoTableViewCell: UITableViewCell {
    @IBOutlet weak var lb_text: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
