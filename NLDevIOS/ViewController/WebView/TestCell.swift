//
//  TestCell.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 4/1/2562 BE.
//  Copyright © 2562 ONaJa. All rights reserved.
//

import UIKit

class TestCell: UITableViewCell {

    @IBOutlet weak var lb_model: UILabel!
    @IBOutlet weak var lb_modeldesc: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
