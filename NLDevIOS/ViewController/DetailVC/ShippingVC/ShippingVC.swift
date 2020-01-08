//
//  ShippingVC.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 27/12/2561 BE.
//  Copyright © 2561 ONaJa. All rights reserved.
//

import UIKit

protocol Recieve {
    func shipSelected(data:ShippingM,count:Int)
}

class ShippingVC: UIViewController {
    
    var navTitle:String = ""
    var indexRow = 0
    var delegate : Recieve?
    var arrayData: [ShippingM]?
    
    let shipItem = [
    ShippingM(shipIMG: UIImage(named: "ic_shipping_thpost")!, shipName: "ThaiPost - Registered", shipDate: "50 ฿  1-2 days"),
    ShippingM(shipIMG: UIImage(named: "ic_shipping_ems_1")!, shipName: "ThaiPost - EMS", shipDate: "50 ฿  1-2 days"),
    ShippingM(shipIMG: UIImage(named: "ic_shipping_kerry")!, shipName: "Kerry Express", shipDate: "50 ฿  1-2 days"),
    ShippingM(shipIMG: UIImage(named: "ic_shipping_scg_1")!, shipName: "SCG Express", shipDate: "50 ฿  1-2 days"),
    ShippingM(shipIMG: UIImage(named: "ic_shipping_nim_1")!, shipName: "Nim Express", shipDate: "50 ฿  1-2 days"),
    ShippingM(shipIMG: UIImage(named: "ic_shipping_7_11_1")!, shipName: "SPEED-D", shipDate: "50 ฿  1-2 days")
    ]

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
    
    func setup(){
        self.title = navTitle
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        tableView.delegate = self
        tableView.dataSource = self
        
        reloadUI()
    }
    
    func reloadUI(){
        tableView.reloadData()
        tableView.layoutIfNeeded()
        tableView.tableFooterView = UIView()
    }


}

extension ShippingVC:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shipItem.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(withIdentifier: "shipCell", for: indexPath) as! ShippingTableViewCell
            
            cell.shipImg.image = shipItem[indexPath.row].shipIMG
            cell.shipNamelbl.text = shipItem[indexPath.row].shipName
            cell.shipDatelbl.text = shipItem[indexPath.row].shipDate
        
        
            cell.shipBtn.layer.borderWidth = 1
            cell.shipBtn.layer.borderColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        if indexPath.row == indexRow {
            cell.shipBtn.layer.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            
        } else {
            cell.shipBtn.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexRow = indexPath.row
       
        delegate?.shipSelected(data: ShippingM(shipIMG: shipItem[indexPath.row].shipIMG!,
                                               shipName: shipItem[indexPath.row].shipName! ,
                                               shipDate: shipItem[indexPath.row].shipDate!), count: 1)
        dismiss(animated: true, completion: nil)
        print()
      
         reloadUI()
       
        self.navigationController?.popViewController(animated: true)
    }
    
}
