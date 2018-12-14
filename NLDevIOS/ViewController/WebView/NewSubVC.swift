//
//  NewSubVC.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 13/12/2561 BE.
//  Copyright © 2561 ONaJa. All rights reserved.
//

import UIKit
import WebKit

class NewSubVC: UIViewController,UIDocumentInteractionControllerDelegate {
    
    final private let linkS = "https://www.google.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        
        self.title = "Share File"
    }
    
    @IBAction func shareText(_ sender: Any) {
        let activityController = UIActivityViewController(activityItems: [linkS], applicationActivities: nil)
        activityController.completionWithItemsHandler = {(nil,completed,_,error) in
            if completed{
                print("Completed!")
            } else {
                print("Canceled!")
            }
        }
        present(activityController, animated: true){
            print("Text Presented!")
        }
        
    }
    
    @IBAction func shareImage(_ sender: Any) {
        
        guard let image = UIImage(named: "DGG") else {
            print("image loading error!")
            return
        }
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityController.completionWithItemsHandler = {(nil,completed,_,error) in
            if completed{
                print("Completed!")
            } else {
                print("Canceled!")
            }
            self.present(activityController, animated: true){
                print("Image Presented!")
            }
            
        }
    }
    
    @IBAction func shareFile(_ sender: Any) {
        guard let url = Bundle.main.url(forResource: "sharePdf", withExtension: "pdf") else { return }
        print(url)
        let controller = UIDocumentInteractionController.init(url: url)
        controller.delegate = self
        controller.presentPreview(animated: true)
    }
    
    func documentInteractionControllerViewControllerForPreview(_ controller:UIDocumentInteractionController) -> UIViewController {
        return self
    }
}
