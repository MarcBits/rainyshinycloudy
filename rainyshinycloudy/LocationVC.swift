//
//  LocationVC
//  rainyshinycloudy
//
//  Created by Marc Cruz on 12/3/16.
//  Copyright © 2016 MarcBits. All rights reserved.
//

import UIKit
import MapKit

class LocationVC: UIViewController, CLLocationManagerDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var latitude: UITextField!
    @IBOutlet weak var longitude: UITextField!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var pointAnnotation: MKPointAnnotation!
    var pinAnnotationView: MKPinAnnotationView!
    
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        return manager
    }()
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if case .authorizedWhenInUse = status {
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Success")
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Fail")
    }
    
    var _selectedLat: Double!
    var _selectedLong: Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        latitude.text = String(format: "%.4f", _selectedLat!)
        longitude.text = String(format: "%.4f", _selectedLong!)
        
        // Init the zoom level
        let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: _selectedLat!, longitude: _selectedLong!)
        let span = MKCoordinateSpanMake(1.0, 0.5)
        let region = MKCoordinateRegionMake(coordinate, span)
        self.mapView.setRegion(region, animated: true)
        
        // Add annotation:
        self.pointAnnotation = MKPointAnnotation()
        self.pointAnnotation.title = "Selected location"
        self.pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: _selectedLat, longitude: _selectedLong)
        
        self.pinAnnotationView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)
        self.mapView.centerCoordinate = self.pointAnnotation.coordinate
        self.mapView.addAnnotation(self.pinAnnotationView.annotation!)
        
//        mapView.showsCompass = true
//        mapView.showsTraffic = true
        mapView.showsScale = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(gestureReconizer:)))
        gestureRecognizer.delegate = self
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    func handleTap(gestureReconizer: UILongPressGestureRecognizer) {
        
        let location = gestureReconizer.location(in: mapView)
        let coordinate = mapView.convert(location,toCoordinateFrom: mapView)
        
        print("here: \(coordinate.latitude),\(coordinate.longitude)")
        
        _selectedLat = coordinate.latitude
        latitude.text = String(format: "%.4f", _selectedLat!)
        
        _selectedLong = coordinate.longitude
        longitude.text = String(format: "%.4f", _selectedLong!)
        
        // Remove previous annotations
        let annotations = self.mapView.annotations
        if annotations.count > 0 {
            for _annotation in annotations {
                self.mapView.removeAnnotation(_annotation)
            }
        }
        
        // Add annotation:
        self.pointAnnotation = MKPointAnnotation()
        self.pointAnnotation.title = "Selected location"
        self.pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: _selectedLat, longitude: _selectedLong)
        
        self.pinAnnotationView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)
        self.mapView.centerCoordinate = self.pointAnnotation.coordinate
        self.mapView.addAnnotation(self.pinAnnotationView.annotation!)
    }
    
    @IBAction func hideKeyboard(_ sender: Any) {
        latitude.resignFirstResponder()
        longitude.resignFirstResponder()
    }

    @IBAction func cancelSelection(_ sender: UIButton) {

        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmSelection(_ sender: UIButton) {
        
        print("Selection confirmed \(sender.tag)")
        
        if let selectedLat = Double(latitude.text!) {
            
            _selectedLat = selectedLat
            
            print("Latitude: \(_selectedLat!)")
        }
        
        if let selectedLong = Double(longitude.text!) {
            
            _selectedLong = selectedLong
            
            print("Longitude: \(_selectedLong!)")
        }
        
        performSegue(withIdentifier: "WeatherVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("preparing for segue")
        
        let destinationVC = segue.destination as! WeatherVC
        destinationVC.selectedLat = _selectedLat
        destinationVC.selectedLong = _selectedLong
    }
  
    @IBAction func zoomIn(_ sender: Any) {
        var region = self.mapView.region
        region.span.latitudeDelta /= 2.0
        region.span.longitudeDelta /= 2.0
        self.mapView.setRegion(region, animated: true)
    }
    
    @IBAction func zoomOut(_ sender: Any) {
        var region = self.mapView.region
        region.span.latitudeDelta  = min(region.span.latitudeDelta  * 2.0, 180.0)
        region.span.longitudeDelta = min(region.span.longitudeDelta * 2.0, 180.0)
        self.mapView.setRegion(region, animated: true)
    }

}
