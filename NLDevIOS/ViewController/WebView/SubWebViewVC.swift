//
//  SubWebViewVC.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 13/12/2561 BE.
//  Copyright © 2561 ONaJa. All rights reserved.
//

import UIKit
import WebKit

class SubWebViewVC: UIViewController,WKNavigationDelegate {
    
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var webView: WKWebView!
    
    var url_s = String()
    
    let pass_string = "Hello world"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        if url_s.count > 0 {
            extractedFunc()
        } else {
            pathToPDF()
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    
    func extractedFunc() {
        let myURL = URL(string: url_s)
        let myRes = URLRequest(url: myURL!)
        webView.load(myRes)
    }
    
    func pathToPDF(){
        
        let pdfFilePath = Bundle.main.url(forResource: "sharePdf", withExtension: "pdf")
        let urlRequest = URLRequest.init(url: pdfFilePath!)
        webView.load(urlRequest)
        
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activity.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activity.stopAnimating()
        activity.isHidden = true
    }
    
    @IBAction func pressGO(_ sender: Any) {
        
        let sb = UIStoryboard.init(name: "WebView",bundle: nil)
        let vc : SubWebVC = sb.instantiateViewController(withIdentifier: "SubWebID") as! SubWebVC
        vc.get_string = pass_string
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
