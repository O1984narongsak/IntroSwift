//
//  PaymentTableViewCell.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 2/1/2562 BE.
//  Copyright © 2562 ONaJa. All rights reserved.
//

import UIKit

class PaymentTableViewCell: UITableViewCell {
    @IBOutlet weak var paymentImg: UIImageView!
    @IBOutlet weak var paymentTypelbl: UILabel!
    @IBOutlet weak var lb_paymentDcs: UILabel!
    @IBOutlet weak var btnSelect: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
