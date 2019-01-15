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
    
    @IBOutlet weak var secMapControl: UISegmentedControl!
    
    let locationManager = CLLocationManager()
    let regionInMaters:Double  = 500
    var userPinView: MKAnnotationView!
    var previousLocation: CLLocation?
    var directionsArray: [MKDirections] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        setThemePlate()
        
    }
    
    let testla : [Double] = [13.2222,14.9999]
    let testlo : [Double] = [99.2222,100.9999]
    let name : [String] = ["Yeah","YeaP" ]
    
    func setThemePlate(){
        
        self.title = "MapView"
        mapView.showsTraffic = true
        mapView.showsScale = true
        mapView.mapType = .mutedStandard
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
        let destnationCoordinate          = getCenterLocation(for: mapView).coordinate
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
        getDirections()
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
