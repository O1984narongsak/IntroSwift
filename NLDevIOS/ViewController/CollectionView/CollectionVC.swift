//
//  CollectionVC.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 12/12/2561 BE.
//  Copyright © 2561 ONaJa. All rights reserved.
//

import UIKit

class CollectionVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let screenSize = UIScreen.main.bounds
    
    let guppy = ["Blue Grass","Blue Dragon","Full Black","Full Gold","Full Red","Half Black","Koi Guppy","Red Glass","RREA","Live Bearer"]
//
    let guppyIMG : [UIImage] = [

        UIImage(named: "blueG")!,
        UIImage(named: "DGG")!,
        UIImage(named: "FBG")!,
        UIImage(named: "FGG")!,
        UIImage(named: "FullRedG")!,
        UIImage(named: "HBrG")!,
        UIImage(named: "KOIG")!,
        UIImage(named: "RedG")!,
        UIImage(named: "RREAG")!,
        UIImage(named: "WGG")!
    ]
//
//    let bgColor : [CGColor] = [
//
//        UIColor(cgColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)) as! CGColor,
//        UIColor(cgColor: #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1))  as! CGColor,
//        UIColor(cgColor: #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1))  as! CGColor,
//        UIColor(cgColor: #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)) as! CGColor,
//        UIColor(cgColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))  as! CGColor,
//    ]
    
     let colorArray = [UIColor.red,UIColor.green,UIColor.blue,UIColor.brown,UIColor.purple]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollection()
        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        self.title = "CollectionView"
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    func setupCollection(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: screenSize.width/2 ,
                                 height: screenSize.height/3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView!.collectionViewLayout = layout
    }
    
}

extension CollectionVC : UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return guppy.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionCell
//
        cell.lblC.text = guppy[indexPath.item]
        cell.imgC.image = guppyIMG[indexPath.item]
//         cell.backgroundColor = colorArray[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.gray.cgColor
        cell?.layer.borderWidth = 2
        presentAlertWithTitle(title: "Yeah", message: "\(indexPath.item + 1)") {
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.lightGray.cgColor
        cell?.layer.borderWidth = 0.5
    }
    
}
