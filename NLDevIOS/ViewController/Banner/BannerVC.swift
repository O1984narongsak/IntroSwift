//
//  BannerVC.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 14/12/2561 BE.
//  Copyright © 2561 ONaJa. All rights reserved.
//

import UIKit

class BannerVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var BanIMG: UIImageView!
    @IBOutlet weak var tableUV: UIView!
    @IBOutlet weak var colUV: UIView!
    @IBOutlet weak var headUV: UIView!
    
    @IBOutlet weak var testlbl: UILabel!
    @IBOutlet weak var scollView_H : NSLayoutConstraint!
    //    var count = 0
    @IBOutlet weak var tableView: UITableView!
    //    var timer: Timer?
    
    
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
    
    var sections = [
        Section(genre: "🦁 Animation",
                movies: ["The Lion King", "The Incredibles"],
                expanded: false),
        Section(genre: "💥 Superhero",
                movies: ["Guardians of the Galaxy", "The Flash", "The Avengers", "The Dark Knight"],
                expanded: false),
        Section(genre: "👻 Horror",
                movies: ["The Walking Dead", "Insidious", "Conjuring","The Walking Dead", "Insidious", "Conjuring","The Walking Dead", "Insidious", "Conjuring","The Walking Dead", "Insidious", "Conjuring"],
                expanded: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        tableView.reloadData()
        tableView.layoutIfNeeded()
//        setupCollection()
        
        //        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updating), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        
        self.title = "Banner"
        BanIMG.image = UIImage(named: "WGG")
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        testlbl.isHidden = false
       
        //        scollView_H.constant = tableUV.frame.height + colUV.frame.height + headUV.frame.height
  
    }
    
    func scrollToBottomAnimated(animated: Bool) {
        guard self.collectionView.numberOfSections > 0 else{
            return
        }
        
        let items = self.collectionView.numberOfItems(inSection: 0)
        if items == 0 { return }
        
        let collectionViewContentHeight = self.collectionView.collectionViewLayout.collectionViewContentSize.height
        let isContentTooSmall: Bool = (collectionViewContentHeight < self.collectionView.bounds.size.height)
        
        if isContentTooSmall {
            self.collectionView.scrollRectToVisible(CGRect(x: 0, y: collectionViewContentHeight - 1, width: 1, height: 1), animated: animated)
            return
        }
        
        self.collectionView.scrollToItem(at: NSIndexPath(item: items - 1, section: 0) as IndexPath, at: .bottom, animated: animated)
        
    }
    
//    func setupCollection(){
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//
//        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
//        layout.itemSize = CGSize(width: (colUV.frame.width - 16) / 2 ,
//                                 height: (colUV.frame.height - 16 ))
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 0
//        collectionView!.collectionViewLayout = layout
//    }
    
    //    @objc func updating() {
    //        if count >= 100 - 1{
    //            timer?.invalidate()
    //            timer = nil
    //            return
    //        }
    //
    //        count += 1
    //        self.title = "\(count) Task Completed"
//        }
    
    
    
}

extension BannerVC : UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return guppyIMG.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "check", for: indexPath) as! BannerCollectionCell
        //
        //        cell.lblC.text = guppy[indexPath.item]
        cell.banIMG.image = guppyIMG[indexPath.item]


        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.gray.cgColor
        cell?.layer.borderWidth = 9
        testlbl.isHidden = true
        presentAlertWithTitle(title: "Yeah", message: "\(indexPath.item + 1)") {

        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {

        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.white.cgColor
        cell?.layer.borderWidth = 0.5
    }

}

extension BannerVC: UITableViewDelegate, UITableViewDataSource, ExpandableHeaderViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].movies.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (sections[indexPath.section].expanded) {
            return 44
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        header.customInit(title: sections[section].genre, section: section, delegate: self)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell")!
        cell.textLabel?.text = sections[indexPath.section].movies[indexPath.row]
        return cell
    }
    
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        sections[section].expanded = !sections[section].expanded
        
        
        tableView.beginUpdates()
        for i in 0 ..< sections[section].movies.count {
            
            tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        
        tableView.endUpdates()
        scollView_H.constant = tableView.contentSize.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        scrollView.scrollToBottom(animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    
    
}

extension UIScrollView {
    func scrollToBottom(animated: Bool) {
        if self.contentSize.height < self.bounds.size.height { return }
        let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height)
        self.setContentOffset(bottomOffset, animated: animated)
    }
}


