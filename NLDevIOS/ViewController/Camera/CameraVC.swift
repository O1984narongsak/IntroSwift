//
//  CameraVC.swift
//  NLDevIOS
//
//  Created by thanaphon on 7/12/2561 BE.
//  Copyright © 2561 ONaJa. All rights reserved.
//

import UIKit
import AVFoundation

class CameraVC: UIViewController {
    
    @IBOutlet weak var oIMGView: UIImageView!
    @IBOutlet weak var oCamera: UIBarButtonItem!
    @IBOutlet weak var oReCapBtn: UIButton!
    
    let captureSession = AVCaptureSession()
    var previewLayer:CALayer!
    var captureDevice:AVCaptureDevice!
    var takePhoto = false

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareCamera()
    }

    func setupView(){
        self.title = "CAMERA"
        oIMGView.isFadeOut()
        oReCapBtn.isFadeOut()
        self.oCamera.isEnabled = true
    }
    
    func prepareCamera() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        
        let availableDevices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back).devices
            captureDevice = availableDevices.first
            beginSession()
    }
        
    @IBAction func takePhoto(_ sender: Any) {
        takePhoto = true
    }
    
    func beginSession () {
            do {
                let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
                
                captureSession.addInput(captureDeviceInput)
                
            }catch {
                print(error.localizedDescription)
            }
            
            
                let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                self.previewLayer = previewLayer
                self.view.layer.addSublayer(self.previewLayer)
                self.previewLayer.frame = self.view.layer.frame
                captureSession.startRunning()
                
                let dataOutput = AVCaptureVideoDataOutput()
                dataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString):NSNumber(value:kCVPixelFormatType_32BGRA)] as [String : Any]
                
                dataOutput.alwaysDiscardsLateVideoFrames = true
                
                if captureSession.canAddOutput(dataOutput) {
                    captureSession.addOutput(dataOutput)
                }
                
                captureSession.commitConfiguration()
                
                
                let queue = DispatchQueue(label: "com.brianadvent.captureQueue")
                dataOutput.setSampleBufferDelegate(self, queue: queue)
        }
    
    func getImageFromSampleBuffer (buffer:CMSampleBuffer) -> UIImage? {
        if let pixelBuffer = CMSampleBufferGetImageBuffer(buffer) {
            let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
            let context = CIContext()
            
            let imageRect = CGRect(x: 0, y: 0, width: CVPixelBufferGetWidth(pixelBuffer), height: CVPixelBufferGetHeight(pixelBuffer))
            
            if let image = context.createCGImage(ciImage, from: imageRect) {
                return UIImage(cgImage: image, scale: UIScreen.main.scale, orientation: .right)
            }
            
        }
        
        return nil
    }
    
    func stopCaptureSession () {
        self.captureSession.stopRunning()
        
        if let inputs = captureSession.inputs as? [AVCaptureDeviceInput] {
            for input in inputs {
                self.captureSession.removeInput(input)
            }
        }
        
    }

}


extension CameraVC : AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        
        if takePhoto {
            takePhoto = false
            
            if let image = self.getImageFromSampleBuffer(buffer: sampleBuffer) {
                DispatchQueue.main.async {
                    self.previewLayer.removeFromSuperlayer()
                    self.oReCapBtn.isFadeIn()
                    self.oReCapBtn.isFadeIn()
                    self.oIMGView.image = image
                    self.oCamera.isEnabled = false
                    self.stopCaptureSession()
                }
            }
        }
    }

}
