//
//  BeaconVC.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 18/12/2561 BE.
//  Copyright © 2561 ONaJa. All rights reserved.
//

import UIKit
import CoreLocation

// Create LocationManager object

// Set a reason as to why we're asking for that in the info.plist

// Request authorization on the device

// CLRegion - All the beacon's date

// IF the user's authorized, then we're going to start ranging for the beacon we'vw set up

// read the proximity property on the beacon as it's ranged and change the screen colour  based on that

class BeaconVC: UIViewController {
    
    var locationManager: CLLocationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()

        // Do any additional setup after loading the view.
    }
    
    func rangeBeacon() {
        
        let uuid = UUID(uuidString: "3490d6bf-c649-4d42-ad78-daf6b4274425")!
        let major:CLBeaconMajorValue = 0
        let minor:CLBeaconMinorValue = 0
        let identifier = "Beacons"
        
        let region = CLBeaconRegion(proximityUUID: uuid, major: major, minor: minor, identifier: identifier)
        
        locationManager.startRangingBeacons(in: region)
        
    }


}
//
extension BeaconVC: CLLocationManagerDelegate {
    
    //MARK: - Location Manager Delegate
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedAlways {
            
            // User has authorized the application - range those beacons.
            rangeBeacon()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        
        guard let discoveredBeaconProximity = beacons.first?.proximity else { print("Could not find the beacon!"); return }
        
        let backgroundColour:UIColor = {
            
            switch discoveredBeaconProximity {
               
            case .immediate: return UIColor.green
            case .near : return UIColor.orange
            case .far: return UIColor.red
            case .unknown: return UIColor.black
            }
        }()
        
        view.backgroundColor = backgroundColour
    }
    
    
}
