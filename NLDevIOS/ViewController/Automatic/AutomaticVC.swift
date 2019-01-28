//
//  AutomaticVC.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 24/1/2562 BE.
//  Copyright © 2562 ONaJa. All rights reserved.
//

import UIKit

class AutomaticVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var textInput: UITextField!
    
  
    var auteurs = ["thsi is good .",
                  "thsi is good model of EV vehicle then mobilitie of transport of the the nest 21st Century and now that EV have prove the limitation of batterly type of litheam ,and now you will see it.","thsi is good model of EV vehicle then mobilitie of transport of the the nest 21st Century and now that EV have prove the limitation of batterly type of litheam ,and now you will see it.thsi is good model of EV vehicle then mobilitie of transport of the the nest 21st Century and now that EV have prove the limitation of batterly type of litheam ,and now you will see it."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        
        self.title = "Automatic"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        
    }
    
    @IBAction func pressFarmsukBtn(_ sender: Any) {
        if let appURL = URL(string: "farmhug://"){
            let canOpen = UIApplication.shared.canOpenURL(appURL)
            print("\(canOpen)")

            let appName = "farmhug"
            let appScheme = "\(appName)://"
            let appSchemeURL = URL(string: appScheme)

            if UIApplication.shared.canOpenURL(appSchemeURL! as URL) {
                UIApplication.shared.open(appSchemeURL!, options: [:], completionHandler: nil )
            } else {
                let alert = UIAlertController(title: "\(appName) Error.. )", message: "The app named \(appName) was not found, please install via appstore. ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
//        let appUrl = URL(string: "farmhug://")
//        UIApplication.shared.canOpenURL(appUrl!)
        
    }
    @IBAction func testURLScheme(_ sender: Any) {
        if let appURL = URL(string: "twitter://"){
            let canOpen = UIApplication.shared.canOpenURL(appURL)
            print("\(canOpen)")
            
            let appName = "Twitter"
            let appScheme = "\(appName)://"
            let appSchemeURL = URL(string: appScheme)
            
            if UIApplication.shared.canOpenURL(appSchemeURL! as URL) {
                UIApplication.shared.open(appSchemeURL!, options: [:], completionHandler: nil )
            } else {
                let alert = UIAlertController(title: "\(appName) Error.. )", message: "The app named \(appName) was not found, please install via appstore. ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        
    }
    
    @IBAction func navLineBTN(_ sender: Any) {
        if let appURL = URL(string: "LINE://"){
            let canOpen = UIApplication.shared.canOpenURL(appURL)
            print("\(canOpen)")
            
            let appName = "LINE"
            let appScheme = "\(appName)://"
            let appSchemeURL = URL(string: appScheme)
            
            if UIApplication.shared.canOpenURL(appSchemeURL! as URL) {
                UIApplication.shared.open(appSchemeURL!, options: [:], completionHandler: nil )
            } else {
                let alert = UIAlertController(title: "\(appName) Error.. )", message: "The app named \(appName) was not found, please install via appstore. ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
        
    @IBAction func passData(_ sender: Any) {
        
        let text = self.textInput.text?.replacingOccurrences(of: " ", with: "%20")
        UIApplication.shared.open(URL(string: "farmsukshop.com://?searchText=\(text!)")!, options: [:], completionHandler: nil)
        
    }
    


}
