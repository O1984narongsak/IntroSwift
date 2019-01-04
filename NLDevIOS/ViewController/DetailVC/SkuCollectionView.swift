//
//  SkuCollectionView.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 3/1/2562 BE.
//  Copyright © 2562 ONaJa. All rights reserved.
//

import UIKit

class SkuCollectionView: UICollectionView,UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    

    override func numberOfItems(inSection section: Int) -> Int {
        return 10
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "skuCell", for: indexPath) as! SkuCollectionCell
            cell.uiView.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.gray.cgColor
        cell?.layer.borderWidth = 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.lightGray.cgColor
        cell?.layer.borderWidth = 0.5
    }
    
    
//    func setupCollection(){
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        layout.itemSize = CGSize(width: screenSize.width/2 ,
//                                 height: screenSize.height/3)
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 0
//        collectionView!.collectionViewLayout = layout
//    }

}
