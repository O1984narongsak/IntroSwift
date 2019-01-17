//
//  ThemeVC.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 17/12/2561 BE.
//  Copyright © 2561 ONaJa. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Contacts

class ThemeVC: UIViewController {
    
    @IBOutlet weak var addresslbl: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var btn_DropDown: UIButton!
    
    @IBOutlet weak var btn_Nav: UIButton!
    @IBOutlet weak var secMapControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var table_H: NSLayoutConstraint!
    
    var testDrop = ["1","2","3"]
    
    var secondM = 1
    var timeM = Timer()
    
   
    let regionInMaters:Double  = 500
    
    var userPinView: MKAnnotationView!
    var previousLocation: CLLocation?
    var directionsArray: [MKDirections] = []
    var firstDR:Bool = true
    var locationCoordinate:CLLocationCoordinate2D = CLLocationCoordinate2D()
    var annotation = MKPointAnnotation()
    var line:MKPolyline = MKPolyline()
    var tgNav:Bool = true
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        setThemePlate()
        tableView.isHidden = true
 
        gestureTouch()
  
    }
    
    let testla : [Double] = [13.2222,14.9999]
    let testlo : [Double] = [99.2222,100.9999]
    let name : [String] = ["Yeah","YeaP" ]
    
    func setThemePlate(){
        
        self.title = "MapView"
        mapView.showsTraffic = true
        mapView.showsScale = true
        mapView.mapType = .mutedStandard
        tableView.delegate = self
        tableView.dataSource = self
        btn_Nav.layer.cornerRadius = 5
        btn_DropDown.layer.cornerRadius = 5
    }
    
    //TODO: - DropDown
    @IBAction func pressDropDown(_ sender: Any) {
        if tableView.isHidden{
            animate(toogle: true)
            
        } else {
            animate(toogle: false)
            
        }
        
    }
    
    func animate(toogle:Bool){
        if toogle {
            UIView.animate(withDuration: 0.3){
                self.tableView.isHidden = false
                self.btn_DropDown.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                if self.tableView.contentSize.height > (self.view.frame.height * 0.8) {
                    self.table_H.constant = (self.view.frame.height * 0.5)
                    self.tableView.isScrollEnabled = true
                }else{
                    self.table_H.constant = self.tableView.contentSize.height
                    self.tableView.isScrollEnabled = false
                }
//                let table_H = self.tableView.bounds.size.height
//                self.tableView.scrollRectToVisible(CGRect(x: 0, y: table_H - 1, width: 1, height: 1), animated: toogle)
            }
        } else {
            UIView.animate(withDuration: 0.3){
                self.tableView.isHidden = true
                self.btn_DropDown.backgroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
            }
        }
    }
    
    //TODO: - LongPress Gesture
    
    @objc func handleLongPress(gestureReconizer: UILongPressGestureRecognizer){
        self.mapView.removeOverlay(line)
        
        if gestureReconizer.state != UILongPressGestureRecognizer.State.ended {
            if(!firstDR){
//            mapView.removeAnnotations(annotation)
            }
            firstDR = false
            let touchLC = gestureReconizer.location(in: mapView)
            self.locationCoordinate = mapView.convert(touchLC, toCoordinateFrom: mapView)
            
            annotation.coordinate = locationCoordinate
            mapView.addAnnotation(annotation)
            print("Tapped : \(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")
            return
        }
        if gestureReconizer.state != UIGestureRecognizer.State.began {
            return
        }
        
    }
    
    func setupLocationManager(){
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    
    func centerViewOnUserLocation(){
        
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMaters, longitudinalMeters: regionInMaters)
            mapView.setRegion(region, animated: true)
        }
        
    }
    
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled(){
            checkLocationAuthorization()
            setupLocationManager()
        } else {
            presentAlertWithTitle(title: "Noo", message: "KKKK" ){}
        }
    }
    
    func checkLocationAuthorization() {
        
        switch CLLocationManager.authorizationStatus(){
        case .authorizedWhenInUse:
            // Do Map Stuff
            startTrackingUserLocation()
        case .denied:
            // Show alert how to turn on direction
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            // Show an alert letting them know what's up
            break
        case .authorizedAlways:
            break
        }
    }
    
    func startTrackingUserLocation(){
        mapView.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.stopUpdatingLocation()
        previousLocation = getCenterLocation(for: mapView)
        configure(latitudes: testla,
                  longitudes: testlo,
                  names: name)
    }
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        
        let latitude = mapView.centerCoordinate.latitude
        let longtitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longtitude)
    }
    
    func configure(latitudes: [Double], longitudes: [Double], names: [String]){
        
        
        
        let coordinates = zip(latitudes, longitudes).map(CLLocationCoordinate2D.init)
        
        let annotations = zip(coordinates, names)
            .map { (coordinate, name) -> MKPointAnnotation in
                let annotation = MKPointAnnotation()
                
                annotation.coordinate = coordinate
                annotation.title = name
                
                return annotation
        }
        
        
        
        self.mapView.addAnnotations(annotations)
        self.mapView.showAnnotations(annotations, animated: true)
    }
    
    //MARK: - Custom Annotation
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseIdentifier = "my_pin"
        
        //        let identifier = "marker"
        //        var view: MKMarkerAnnotationView
        //
        //        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView{
        //            dequeuedView.annotation = annotation
        //            view = dequeuedView
        //        } else {
        //            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        //            view.canShowCallout = true
        //            view.calloutOffset = CGPoint(x: -5, y: 5)
        //            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        //        }
        //
        //        return view
        //
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        if annotation is MKUserLocation {
            let pin = mapView.view(for: annotation) ?? MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
            
            let iMG:UIImage = UIImage(named: "nearby_icon_selected")!
            
            pin.image = iMG
            userPinView = pin
            return pin
        }
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            
        } else {
            annotationView?.annotation = annotation
            
            //            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
        }
        
        annotationView?.isDraggable = false
        annotationView?.canShowCallout = true
        annotationView?.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        annotationView?.image = UIImage(named: "icons8-marker-25")
        return annotationView
    }
    
    func getDirections() {
        
        guard let location = locationManager.location?.coordinate else {
            //TODO: Inform user we don't current locaion
            return
        }
        
        print(location)
        let request = createDirectionRequest(from: location)
        let directions = MKDirections(request: request)
        resetMapView(withNew: directions)
        
        directions.calculate { [unowned self] (response, error) in
            //TODO: Handle error if needed
            guard let response = response else { return } //TODO: Show response not available in an alert
            
            for route in response.routes {
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                let eta = route.expectedTravelTime
                let distance = route.distance
                let transType = route.transportType
                print(eta)
                print(distance)
                print(transType)
            }
        }
    }
    
    func createDirectionRequest(from coordinate: CLLocationCoordinate2D) -> MKDirections.Request {
        let destnationCoordinate          = annotation.coordinate
//        let destnationCoordinate          = getCenterLocation(for: mapView).coordinate
        let startingLocation              = MKPlacemark(coordinate: coordinate)
        let destination                   = MKPlacemark(coordinate: destnationCoordinate)
        
        let startPin = customPin(pinTitle: "You here!", pinSubtitle: "", location: coordinate)
        let destinationPin = customPin(pinTitle: "Destination", pinSubtitle: "", location: destnationCoordinate)
        self.mapView.addAnnotation(startPin)
        self.mapView.addAnnotation(destinationPin)
        
        let request                       = MKDirections.Request()
        request.source                    = MKMapItem(placemark: startingLocation)
        request.destination               = MKMapItem(placemark: destination)
        request.transportType             = .walking
        request.requestsAlternateRoutes   = true
        print(destnationCoordinate)
        return request
    }
    
    func resetMapView(withNew directions: MKDirections){
        mapView.removeOverlays(mapView.overlays)
        directionsArray.append(directions)
        let _ = directionsArray.map { $0.cancel()}
    }
    
    @IBAction func goButtonTapped(_ sender: UIButton){
        if tgNav {
            toogleNav(tgNav: true)
           
        } else {
            toogleNav(tgNav: false)
            tgNav = true
        }
  
    }
    
    @objc func updateTimeM(){
        secondM += 1
        btn_Nav.setTitleColor(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), for: .normal)
        if secondM % 2 == 0 {
            btn_Nav.setTitleColor(#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), for: .normal)
        }
        if secondM % 3 == 0 {
//            btn_Nav.setTitleColor(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), for: .normal)
            getDirections()
            print(secondM)
            secondM = 0
        }
        
    }
    
    func toogleNav(tgNav:Bool){
        if tgNav {
            self.timeM = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ThemeVC.updateTimeM), userInfo: nil, repeats: true)
            
            btn_Nav.backgroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
            
            self.tgNav = false
        } else {
            
            self.timeM.invalidate()
            
            btn_Nav.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            btn_Nav.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            print("Stop Nav")
            self.tgNav = true
            
        }
    }
    
    @IBAction func segMapTapped(_ sender: Any) {
        
        let getIndex = secMapControl.selectedSegmentIndex
        
        switch (getIndex) {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        default:
            mapView.mapType = .standard
        }
    }
    
    
    
}
extension ThemeVC : CLLocationManagerDelegate {
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude )
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMaters + 50, longitudinalMeters: regionInMaters + 50 )
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //
        checkLocationAuthorization()
    }
    
    
}

extension ThemeVC : MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(for: mapView)
        let geoCoder = CLGeocoder()
        
        guard let previousLocation = self.previousLocation else { return }
        
        guard center.distance(from: previousLocation) > 50 else { return }
        self.previousLocation = center
        
        geoCoder.cancelGeocode()
        
        geoCoder.reverseGeocodeLocation(center) { [weak self](placemarks, error) in
            guard let self = self else { return }
            if let _ = error {
                //TODO: - Show ALert
                self.presentAlertWithTitle(title: "error", message: ""){}
                return
            }
            
            guard let placemark = placemarks?.first else{
                //TODO: Show alert inforrming the user
                return
            }
            
            let streetNumber = placemark.subThoroughfare ?? ""
            let streetname = placemark.subThoroughfare ?? ""
            let subprovince = placemark.subLocality ?? ""
            let province = placemark.locality ?? ""
            DispatchQueue.main.async {
                self.addresslbl.text = "\(streetNumber) \(streetname)sP: \(subprovince) P:\(province)"
            }
            
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        renderer.strokeColor = .green
        renderer.lineWidth = 1
        //        renderer.strokeColor = .blue
        
        return renderer
    }
    
    //    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    //
    //        guard let annotation = annotation as? customPin else { return nil }
    //        let identifier = "marker"
    //        var view: MKMarkerAnnotationView
    //
    //        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
    //
    //            dequeuedView.annotation = annotation
    //            view = dequeuedView
    //        } else {
    //            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
    //            view.canShowCallout = true
    //            view.calloutOffset = CGPoint(x: -5, y: 5)
    //            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
    //        }
    //
    //        return view
    //
    //    }
}

class customPin: NSObject,MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(pinTitle:String,pinSubtitle:String,location:CLLocationCoordinate2D){
        self.title = pinTitle
        self.subtitle = pinSubtitle
        self.coordinate = location
    }
}

//TODO: - tableViewDropDown
extension ThemeVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testDrop.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellDrop", for: indexPath) as! TestDropCell
        cell.lb_DType?.text = testDrop[indexPath.row]
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
}

extension ThemeVC : UIGestureRecognizerDelegate {
    func gestureTouch(){
        
        self.mapView.delegate = self
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(ThemeVC.handleLongPress(gestureReconizer:)))
        
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        self.mapView.addGestureRecognizer(lpgr)
    }
    
}
