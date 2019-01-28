//
//  SubProductCollectionView.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 4/1/2562 BE.
//  Copyright © 2562 ONaJa. All rights reserved.
//

import UIKit

class SubProductCollectionView: UICollectionView {

    private let cellItems = ["All", "Design", "Development", "Social","Geteooeooe","Lolokloklo"]
    
    override func awakeFromNib() {
        self.delegate = self
        self.dataSource = self
    }

}
extension SubProductCollectionView : UICollectionViewDelegate , UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellItems.count
    }
    
//    func collectionView(_ collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout {
//        return CGSize(width: , height: <#T##CGFloat#>)
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubProductCollectionViewCell", for: indexPath) as! SubProductCollectionViewCell
        cell.lb_SubColCell.adjustsFontSizeToFitWidth    =   true
        cell.lb_SubColCell.text = cellItems[indexPath.item]
//        cell.lb_SubColCell.sizeToFit()
        cell.bg_SubColCell.addSubview(cell.lb_SubColCell)

        cell.lb_SubColCell.adjustsFontSizeToFitWidth    =   true
        cell.contentView.layer.cornerRadius = 0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        cell.contentView.layer.masksToBounds = true;
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let colorC = hexStringToUIColor(hex: "#4a4a4a")
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = colorC.cgColor
        cell?.layer.borderWidth = 0.5
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
