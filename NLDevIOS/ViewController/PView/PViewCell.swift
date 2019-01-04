//
//  PViewCell.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 21/12/2561 BE.
//  Copyright © 2561 ONaJa. All rights reserved.
//

import UIKit

class PViewCell: UITableViewCell {

    @IBOutlet weak var imgPV: UIImageView!
    
    @IBOutlet weak var lblPV: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func getIdentification() -> NSString{
        return "PViewCell"
    }
    class func getHeight() -> CGFloat{
        return 110
    }

}
