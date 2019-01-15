//
//  ScreenRecVC.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 25/12/2561 BE.
//  Copyright © 2561 ONaJa. All rights reserved.
//

import UIKit
import ReplayKit

class ScreenRecVC: UIViewController {
    
    @IBOutlet weak var lblScreenH: UILabel!
    @IBOutlet weak var secctionView: UISegmentedControl!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var lblSoundS: UILabel!

    @IBOutlet weak var audioSwitch: UISwitch!
    
 
    
    @IBOutlet weak var ScreenRecBtn: UIButton!
    
    var recorder = RPScreenRecorder.shared()
    private var isRecording = false
    
    
    @IBAction func imgPicked(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
            case 0:
            imgView.image = UIImage(named: "TL_SS")
        case 1:
            imgView.image = UIImage(named: "TL_3S")
        case 2:
            imgView.image = UIImage(named: "TL_XS")
        case 3:
            imgView.image = UIImage(named: "Tl_RS")
        default:
            imgView.image = UIImage(named: "FGG")
        }
    }
    
    
    @IBAction func recordBtn(_ sender: Any) {
        if !isRecording{
            startRec()
        }else{
            stopRec()
        }
    }
    
    func startRec(){
        guard recorder.isAvailable else {
            print("Recording is not available at this time.")
            return
        }
        
        if audioSwitch.isOn {
            recorder.isMicrophoneEnabled = true
            
        } else {
            recorder.isMicrophoneEnabled = false
        }
        
        recorder.startRecording { (error) in
            guard error == nil else {
                print("There eas an error starting the recording.")
                return
                
            }
            
            print("STARTED RECORDING SUCCESSFULLY")
            DispatchQueue.main.async {
                self.audioSwitch.isEnabled = false
                self.ScreenRecBtn.setTitleColor(#colorLiteral(red: 0.9568627451, green: 0.2109209933, blue: 0.287923428, alpha: 1), for: .normal)
                self.ScreenRecBtn.setTitle("Stop", for: .normal)
                self.lblScreenH.text = "Recording...."
                self.lblScreenH.textColor = #colorLiteral(red: 0.9568627451, green: 0.2109209933, blue: 0.287923428, alpha: 1)
                self.isRecording = true
            }
           
        }
    }
    
    func stopRec(){
        recorder.stopRecording { (preview, error) in
            guard preview != nil else {
                print ("Preview Controller is not availible")
                return
            }
            
            let alert = UIAlertController(title: "Finishined Recording", message: "Would your like to delete your recording?", preferredStyle: .alert)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
                self.recorder.discardRecording {
                    print("Recording successfully deleted!")
                }
            })
            
            let editAction = UIAlertAction(title: "Edit", style: .default, handler: { (action) in
                preview?.previewControllerDelegate = self
                self.present(preview!,animated: true,completion: nil)
            })
            
            alert.addAction(deleteAction)
            alert.addAction(editAction)
            self.present(preview!,animated: true,completion: nil)
            
            self.isRecording = false
            self.viewReset()
        }
    }
    
    func viewReset(){
        audioSwitch.isEnabled = true
        lblScreenH.text = "Ready to Record"
        lblScreenH.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ScreenRecBtn.setTitle("Record", for: .normal)
        ScreenRecBtn.setTitleColor(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), for: .normal)
    }
    
}

extension ScreenRecVC : RPPreviewViewControllerDelegate {
    func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
        dismiss(animated: true, completion: nil)
    }
}
