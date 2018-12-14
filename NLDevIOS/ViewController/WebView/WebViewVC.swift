//
//  WebViewVC.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 13/12/2561 BE.
//  Copyright © 2561 ONaJa. All rights reserved.
//

import UIKit

class WebViewVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var menuItem = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addMenu()
        setupTableView()
        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        self.title = "WebView"
    }
    
    func addMenu(){
        menuItem.append("SubWebView")
        menuItem.append("YouTube")
        menuItem.append("Share")
        menuItem.append("OpenPDF")
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: "MainMenuCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
}

extension WebViewVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MainMenuCell
        cell.lb_title.text = menuItem[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "WebView", bundle: nil)
        let SubWebViewVC = storyboard.instantiateViewController(withIdentifier: "SubWebViewID") as! SubWebViewVC
        
        switch indexPath.row {
        case 0:
            SubWebViewVC.url_s = "https://bulbapedia.bulbagarden.net/wiki/Main_Page"
            navigationController?.pushViewController(SubWebViewVC,animated: true)
            break
        case 1:
            SubWebViewVC.url_s = "https://www.youtube.com/watch?v=6tz1_znrbmc"
            navigationController?.pushViewController(SubWebViewVC,animated: true)
            break
        case 2:
            let NewSubVC = storyboard.instantiateViewController(withIdentifier: "NewSubID") as! NewSubVC
            navigationController?.pushViewController(NewSubVC,animated: true)
            break
        case 3:
            navigationController?.pushViewController(SubWebViewVC,animated: true)
            break
        default:
            break
        }
    }
}
