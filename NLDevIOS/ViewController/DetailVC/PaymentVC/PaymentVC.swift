//
//  PaymentVC.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 2/1/2562 BE.
//  Copyright © 2562 ONaJa. All rights reserved.
//

import UIKit

protocol GetPayment {
    func paymentSelected(data:SubPaymentM,count:Int)
}

class PaymentVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var rowSelect = 0
    var sectionSelect = 0
    var rowExpand = 999
    let lbVAT = "รอยืนยัน 5 นาทีหลังจากชำระเงิน"
    
    var mPaymentList : [PaymentM] = []
    var delegate : GetPayment?

    @IBOutlet weak var constraintHeightFromTable: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        setup()
        rowExpand = 0
        constraintHeightFromTable.constant = 0
        // Do any additional setup after loading the view.
    }
    
    func setup(){
        
        let test = [
            PaymentM(paymentIMG: UIImage(named: "combined_shape")!, paymentType: "โอน/ชำระผ่าน ธนาคาร", paymentDc: "", subpayment: []),
            PaymentM(paymentIMG: UIImage(named: "ic_creditcard")!, paymentType: "บัตรเครดิต", paymentDc: "ค่าบริการ 3%", subpayment: []),
            PaymentM(paymentIMG: UIImage(named: "ic_ibanking")!, paymentType: "อินเตอร์เน็ทแบงค์กิ้ง", paymentDc: "เลือกธนาคารที่ต้องการ", subpayment:[
                SubPaymentM(sPaymentIMG:UIImage(named: "ic_bank_1")!, sPaymentType: "ธนาคารกรุงศรี", sPaymentDc: "รอยืนยัน 5 นาทีหลังจากชำระเงิน"),
                SubPaymentM(sPaymentIMG:UIImage(named: "ic_bank_2")!, sPaymentType: "ธนาคารกรุงไทย", sPaymentDc: "รอยืนยัน 5 นาทีหลังจากชำระเงิน"),
                SubPaymentM(sPaymentIMG:UIImage(named: "ic_bank_3")!, sPaymentType: "ธนาคารกรุงเทพ", sPaymentDc: "รอยืนยัน 5 นาทีหลังจากชำระเงิน"),
                SubPaymentM(sPaymentIMG: UIImage(named: "ic_bank_4")!, sPaymentType: "ธนาคารไทยพานิชย์", sPaymentDc: "รอยืนยัน 5 นาทีหลังจากชำระเงิน" ),
                SubPaymentM(sPaymentIMG: UIImage(named: "ic_bank_5")!, sPaymentType: "ธนาคารทหารไทย", sPaymentDc: "รอยืนยัน 5 นาทีหลังจากชำระเงิน"),
                SubPaymentM(sPaymentIMG: UIImage(named: "ic_bank_6")!, sPaymentType: "ธนาคารยูโอบี", sPaymentDc: "รอยืนยัน 5 นาทีหลังจากชำระเงิน")
                ]),
            PaymentM(paymentIMG:UIImage(named: "mpayicon")!, paymentType: "เอ็มเปย์", paymentDc: "รอยืนยัน 5 นาทีหลังจากชำระเงิน", subpayment: [])
        ]
        
        mPaymentList = test
    }
    
    @objc func actionHearderTableview(sender: UIButton) {
        if mPaymentList[sender.tag].subpayment.count <= 0 {
            sectionSelect = sender.tag
            delegate?.paymentSelected(data: SubPaymentM(
                sPaymentIMG: mPaymentList[sectionSelect].paymentIMG!,
                sPaymentType: mPaymentList[sectionSelect].paymentType!,
                sPaymentDc: mPaymentList[sectionSelect].paymentDc!),
                                      count: 1)
        }
        
        if rowExpand == (sender.tag) {
            rowExpand = 999
        }
        else {
            rowExpand = (sender.tag)
        }
        
        reloadUI()
        constraintHeightFromTable.constant = tableView.contentSize.height
    }
    
    func reloadUI(){
        tableView.reloadData()
        tableView.layoutIfNeeded()
        tableView.tableFooterView = UIView()
    }
    
}

extension PaymentVC : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return mPaymentList.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UINib(nibName: "PaymentOptionHeader", bundle: nil).instantiate(withOwner: nil, options: nil).first as! UIView
        
        let btn_dropdown = view.viewWithTag(555) as! UIButton
        let img_dropdown = view.viewWithTag(999) as! UIImageView
        let btn_select = view.viewWithTag(9) as! UIButton
        
        let img_paymentLogo = view.viewWithTag(99) as! UIImageView
        let lb_paymentName = view.viewWithTag(19) as! UILabel
        let lb_paymentDc = view.viewWithTag(18) as! UILabel
        
        if let model = mPaymentList[section] as PaymentM?{
            lb_paymentName.text = model.paymentType ?? ""
            img_paymentLogo.image = model.paymentIMG
            lb_paymentDc.text = model.paymentDc
            if model.subpayment.count <= 0 {
                img_dropdown.isHidden = true
            }else{
                img_dropdown.isHidden = false
            }
            
            if model.paymentDc == ""{
                lb_paymentDc.isHidden = true
            }else{
                lb_paymentDc.isHidden = false
            }
        }
        btn_dropdown.addTarget(self, action: #selector(actionHearderTableview(sender: ) ), for: .touchUpInside)
        btn_dropdown.tag = section
        
        if rowExpand == section {
            img_dropdown.image = UIImage(named: "ic_seemore_down")!
            
        } else {
            btn_select.layer.cornerRadius = 1
            btn_select.layer.borderColor = #colorLiteral(red: 0.1215686275, green: 0.1294117647, blue: 0.1411764706, alpha: 1)
        }
        
        if sectionSelect == section {
            btn_select.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            btn_select.layer.cornerRadius = 0
            btn_select.layer.borderWidth = 1
            btn_select.layer.borderColor = #colorLiteral(red: 0.1215686275, green: 0.1294117647, blue: 0.1411764706, alpha: 1)
        } else {
            btn_select.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            btn_select.layer.cornerRadius = 0
            btn_select.layer.borderWidth = 1
            btn_select.layer.borderColor = #colorLiteral(red: 0.1215686275, green: 0.1294117647, blue: 0.1411764706, alpha: 1)
            
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 76
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if rowExpand != section {
            return 0
        }
        
        return mPaymentList[section].subpayment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PaymentTableViewCell? = (tableView.dequeueReusableCell(withIdentifier: "paymentCell") as! PaymentTableViewCell )
        if let model = mPaymentList[indexPath.section] as PaymentM?{
            cell?.paymentTypelbl.text = model.subpayment[indexPath.row].sPaymentType ?? ""
            cell?.paymentImg.image = model.subpayment[indexPath.row].sPaymentIMG
            cell?.lb_paymentDcs.text = model.subpayment[indexPath.row].sPaymentDc ?? ""
            if mPaymentList[indexPath.section].subpayment.count > 0 && sectionSelect == indexPath.section {
                if indexPath.row == rowSelect {
                    cell?.btnSelect.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
                    cell?.btnSelect.layer.cornerRadius = 0
                    cell?.btnSelect.layer.borderWidth = 1
                    cell?.btnSelect.layer.borderColor = #colorLiteral(red: 0.1215686275, green: 0.1294117647, blue: 0.1411764706, alpha: 1)
                } else {
                    cell?.btnSelect.layer.cornerRadius = 0
                    cell?.btnSelect.layer.borderWidth = 1
                    cell?.btnSelect.layer.borderColor = #colorLiteral(red: 0.1215686275, green: 0.1294117647, blue: 0.1411764706, alpha: 1)
                    cell?.btnSelect.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                }
            }else{
                cell?.btnSelect.layer.cornerRadius = 0
                cell?.btnSelect.layer.borderWidth = 1
                cell?.btnSelect.layer.borderColor = #colorLiteral(red: 0.1215686275, green: 0.1294117647, blue: 0.1411764706, alpha: 1)
                cell?.btnSelect.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0.2 , y: 0, width: tableView.frame.size.width, height: 1))
        footerView.backgroundColor = UIColor.gray
        return footerView
    }
    
    // set height for footer
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
}

extension PaymentVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        
        if mPaymentList[indexPath.section].subpayment.count > 0 {
            sectionSelect = indexPath.section
            rowSelect = indexPath.row

            delegate?.paymentSelected(data: SubPaymentM(sPaymentIMG: mPaymentList[sectionSelect].subpayment[rowSelect].sPaymentIMG!,
                                                        sPaymentType: mPaymentList[sectionSelect].subpayment[rowSelect].sPaymentType!,
                                                        sPaymentDc: mPaymentList[sectionSelect].subpayment[rowSelect].sPaymentDc!),
                                      count: 1)
        }
        
        reloadUI()
    }
    
}
