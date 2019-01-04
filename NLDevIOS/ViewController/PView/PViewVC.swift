//
//  PViewVC.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 21/12/2561 BE.
//  Copyright © 2561 ONaJa. All rights reserved.
//

import UIKit

class PViewVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var keepSection : [PView] = []
    var secSelect = 0
    var rowSelect = 0
    var sectionSelect = 0
    
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
  var test = [ PView(genre: "Guppy", type: UIImage(named: "WGG")!, expanded: false,
                     subgenre: [
    PView(genre:"Dragon Guppy", type: UIImage(named: "DGG")!, expanded: false, subgenre: []),
    PView(genre:"Full Back Guppy", type: UIImage(named: "FBG")!, expanded: false, subgenre: []),
    PView(genre:"Full Gold Guppy", type: UIImage(named: "FGG")!, expanded: false, subgenre: [])
    ]),
               PView(genre: "Guppy", type: UIImage(named: "WGG")!, expanded: false,
                     subgenre: [
                        PView(genre:"Dragon Guppy", type: UIImage(named: "DGG")!, expanded: false, subgenre: []),
                        PView(genre:"Full Back Guppy", type: UIImage(named: "FBG")!, expanded: false, subgenre: []),
                        PView(genre:"Full Gold Guppy", type: UIImage(named: "FGG")!, expanded: false, subgenre: [])
                ])]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
}

//@objc func actionHeaderTableview(sender: UIButton){
//    if keepSection[sender.tag].subgenre.count <= 0 {
//        sectionSelect = sender.tag
//    }
//    
//    tableView.reloadData()
//    tableView.layoutIfNeeded()
//}

extension PViewVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UINib(nibName: "PViewHeader", bundle: nil).instantiate(withOwner: nil, options: nil).first as! UIView
        
        let btn_dropdown = view.viewWithTag(11) as! UIButton
        
        let lb_name = view.viewWithTag(55) as! UILabel
        let img_logo = view.viewWithTag(5) as! UIImageView
        
        if let model = test[section] as PView?{
            img_logo.image = model.type
            lb_name.text = model.genre ?? ""
            
        }
        
//        btn_dropdown.addTarget(self, action: #selector(actionHeaderTableview(sender:)), for: .touchUpInside)
        btn_dropdown.tag = section
        
        return view
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  test.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : PViewCell? = (tableView.dequeueReusableCell(withIdentifier: PViewCell.getIdentification() as String) as! PViewCell)
        
        if let model = test[indexPath.section] as PView?{
            cell?.lblPV.text = model.subgenre[indexPath.row].genre ?? ""
            cell?.imgPV.image = model.subgenre[indexPath.row].type
            
        }
        
        return cell!
    }
}

extension PViewVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Yeah")
    }
}
