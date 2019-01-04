//
//  ProductView.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 4/1/2562 BE.
//  Copyright © 2562 ONaJa. All rights reserved.
//

import UIKit

class ProductView: UICollectionView {

    override func awakeFromNib() {
        self.delegate = self
        self.dataSource = self
    }

}

extension ProductView : UICollectionViewDelegate , UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        
        return cell
    }
}
