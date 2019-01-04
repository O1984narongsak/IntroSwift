//
//  DetailVC.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 26/12/2561 BE.
//  Copyright © 2561 ONaJa. All rights reserved.
//

import UIKit



class DetailVC: UIViewController {
    
    @IBOutlet weak var cartBtn: UIBarButtonItem!
    @IBOutlet weak var detailBtn: UIButton!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var toShippingBtn: UIButton!
    @IBOutlet weak var shopImg: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var shipView: UIView!
    @IBOutlet weak var shipImg: UIImageView!
    @IBOutlet weak var shipName: UILabel!
    @IBOutlet weak var shipDate: UILabel!
    
    @IBOutlet weak var paymentImg: UIImageView!
    @IBOutlet weak var paymentTypelbl: UILabel!
    @IBOutlet weak var paymentDClbl: UILabel!
    @IBOutlet weak var paymentView: UIView!
    @IBOutlet weak var paymentBtn: UIButton!
    
    let txtShipBtn = "เลือกวิธีการจัดส่ง"
    let txtDate = "Jan 2,19 to Feb 4,19  "
    let txtCoupon = "ส่วนลด"
    let txtPrice = "2,000"
    
    var shipSelect : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setup()
        // Do any additional setup after loading the view.
    }
    
    func setup(){
        let colorB = hexStringToUIColor(hex: "#b2d234")
        
        let colorA = hexStringToUIColor(hex: "#f8f8f8")
        self.title = "Detail"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = colorB
        
        shareBtn.layer.cornerRadius = 0
        shareBtn.layer.borderWidth = 1
        shareBtn.layer.borderColor = colorB.cgColor
        
        detailBtn.layer.cornerRadius = 0
        detailBtn.layer.borderWidth = 1
        detailBtn.layer.borderColor = colorB.cgColor
        
        likeBtn.layer.cornerRadius = 0
        likeBtn.layer.borderWidth = 1
        likeBtn.layer.borderColor = colorB.cgColor
        
        shopImg.layer.cornerRadius = self.shopImg.frame.size.width / 2
        shopImg.clipsToBounds = true
        
        toShippingBtn.layer.cornerRadius = 0
        toShippingBtn.layer.borderWidth = 1
        toShippingBtn.layer.borderColor = colorB.cgColor
//        toShippingBtn.setTitle(txtShipBtn, for: .normal)
        paymentBtn.layer.cornerRadius = 0
        paymentBtn.layer.borderWidth = 1
        paymentBtn.layer.borderColor = colorB.cgColor
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        shipView.layer.backgroundColor = colorA.cgColor
        
        paymentView.layer.backgroundColor = colorA.cgColor
        
       
   
//        if shipSelect == 0 {
//           toShippingBtn.setTitle(txtShipBtn, for: .normal)
//            toShippingBtn.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        } else {
//           toShippingBtn.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
//            toShippingBtn.setTitle("", for: .normal)
//        }
        
        
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
    
    @IBAction func pressToShipping(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ShippingID") as! ShippingVC
        vc.navTitle = txtShipBtn
        vc.delegate = self
        navigationController?.pushViewController(vc,animated: true)
        
    }
    
    @IBAction func pressToPayment(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PaymentID") as! PaymentVC
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
//MARK: -
extension DetailVC : UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let colorB = hexStringToUIColor(hex: "#b2d234")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "couponCell", for: indexPath) as! CouponCollectionCell
        cell.couponDes.text = txtDate
        cell.couponType.text = txtCoupon
        cell.couponPricelbl.text = txtCoupon
        cell.contentView.layer.cornerRadius = 0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = colorB.cgColor
        cell.contentView.layer.masksToBounds = true;
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let colorC = hexStringToUIColor(hex: "#4a4a4a")
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = colorC.cgColor
        cell?.layer.borderWidth = 0.5
    }
    
}

//MARK: - go to ShippingVC
extension DetailVC: Recieve {
    
    func shipSelected(data:ShippingM,count:Int){
        shipImg.image = data.shipIMG
        shipDate.text = data.shipDate
        shipName.text = data.shipName
        shipSelect = count
        
    }
}

//MARK: - go to PaymentVC
extension DetailVC: GetPayment {
    func paymentSelected(data:SubPaymentM,count:Int){
        paymentImg.image = data.sPaymentIMG
        paymentDClbl.text = data.sPaymentDc
        paymentTypelbl.text = data.sPaymentType
        
    }
}

    


