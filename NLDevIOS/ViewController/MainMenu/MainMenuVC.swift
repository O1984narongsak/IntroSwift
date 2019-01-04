//
//  MainMenuVC.swift
//  NLDevIOS
//
//  Created by thanaphon on 7/12/2561 BE.
//  Copyright © 2561 ONaJa. All rights reserved.
//

import UIKit

class MainMenuVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var menuItem =  [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addMenu()
        setupTableView()
        setupView()
        
    }
    
    func setupView(){
        self.title = "MENU"
    }
    
    func addMenu(){
        menuItem.append("CAMERA")
        menuItem.append("TextField")
        menuItem.append("Collection")
        menuItem.append("WebView")
        menuItem.append("Banner")
        menuItem.append("MapKit")
        menuItem.append("iBeacon")
        menuItem.append("Estimote")
        menuItem.append("PView")
        menuItem.append("ScreenRec")
        menuItem.append("Detail")
        menuItem.append("BasicCollectionInTB")
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: "MainMenuCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
}

extension MainMenuVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MainMenuCell
        cell.lb_title.text = menuItem[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let storyboard = UIStoryboard(name: "Camera", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "CameraID") as! CameraVC
            navigationController?.pushViewController(vc,animated: true)
            break
        case 1:
            let storyboard = UIStoryboard(name: "TextField", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "TextFieldID") as! TextFieldVC
            navigationController?.pushViewController(vc,animated: true)
            break
        case 2:
            let storyboard = UIStoryboard(name: "Collection", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "CollectionID") as! CollectionVC
            navigationController?.pushViewController(vc,animated: true)
            break
        case 3:
            let storyboard = UIStoryboard(name: "WebView", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "WebViewID") as! WebViewVC
            navigationController?.pushViewController(vc,animated: true)
            break
        case 4:
            let storyboard = UIStoryboard(name: "Banner", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "BannerID") as! BannerVC
            navigationController?.pushViewController(vc,animated: true)
            break
        case 5:
            let storyboard = UIStoryboard(name: "Theme", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ThemeID") as! ThemeVC
            navigationController?.pushViewController(vc,animated: true)
            break
        case 6:
            let storyboard = UIStoryboard(name: "Beacon", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "BeaconID") as! BeaconVC
            navigationController?.pushViewController(vc,animated: true)
            break
        case 7:
            let storyboard = UIStoryboard(name: "Estimote", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "EstimoteID") as! EstimoteVC
            navigationController?.pushViewController(vc,animated: true)
            break
        case 8:
            let storyboard = UIStoryboard(name: "PView", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "PViewID") as! PViewVC
            navigationController?.pushViewController(vc,animated: true)
            break
        case 9:
            let storyboard = UIStoryboard(name: "ScreenRec", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ScreenRecID") as! ScreenRecVC
            navigationController?.pushViewController(vc,animated: true)
            break
        case 10:
            let storyboard = UIStoryboard(name: "Detail", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "DetailID") as! DetailVC
            navigationController?.pushViewController(vc,animated: true)
            break
        case 11:
            let storyboard = UIStoryboard(name: "BasicCollectionInTB", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "BasicCollectionInTBID") as! BasicCollectionInTBVC
            navigationController?.pushViewController(vc,animated: true)
            break
            
        default:
            break
        }
    }
    
}
