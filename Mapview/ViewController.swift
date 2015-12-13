//
//  ViewController.swift
//  Mapview
//
//  Created by quy on 12/12/15.
//  Copyright © 2015 ios. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class ViewController: UIViewController ,MKMapViewDelegate,CLLocationManagerDelegate{
    var locations = CLLocationManager()
    @IBOutlet weak var map: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        locations.delegate = self;
        locations.desiredAccuracy = kCLLocationAccuracyBest;
        locations.requestAlwaysAuthorization()
        locations.startUpdatingLocation()
        let latitude : CLLocationDegrees   = 21.0103460
        let longtitude : CLLocationDegrees    = 105.8364969
        let latDelta : CLLocationDegrees = 0.0005    ;
        let longDelta : CLLocationDegrees  = 0.005;
        let span :MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        let location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longtitude)
        let region  : MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        map.setRegion(region, animated: true)
        let anotation : MKPointAnnotation   = MKPointAnnotation()
        anotation.coordinate = location
        anotation.title = "Ha noi"
        anotation.subtitle = "i will be here"
       map.addAnnotation(anotation)
        let longPress = UITapGestureRecognizer(target: self, action: "action:")
        longPress.numberOfTapsRequired = 1
        map.addGestureRecognizer(longPress)
        // Do any additional setup after loading the view, typically from a nib.
    }
    func action(longPress : UIGestureRecognizer){
        let latDelta : CLLocationDegrees = 0.0005    ;
        let longDelta : CLLocationDegrees  = 0.005;
        let span :MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)

      let location  = longPress.locationInView(self.map)
        let newCoordiante = self.map.convertPoint(location, toCoordinateFromView: self.map)
        let newregion : MKCoordinateRegion = MKCoordinateRegionMake(newCoordiante, span)
        map.setRegion(newregion, animated: true)
        let newAnotation :MKPointAnnotation = MKPointAnnotation()
        newAnotation.coordinate = newCoordiante
        
        newAnotation.title = "Phu Quoc"
        newAnotation.subtitle = "I will be there"
        map.addAnnotation(newAnotation)
//        let latitude : CLLocationDegrees   = point.x
//        let longtitude : CLLocationDegrees    = point.y

        print("anotation")
        
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation : CLLocation  = locations[0] 
        let latitude  = newLocation.coordinate.latitude
        let longtitude = newLocation.coordinate.longitude
        let latDelta : CLLocationDegrees = 0.0005    ;
        let longDelta : CLLocationDegrees  = 0.005;
        let span  = MKCoordinateSpanMake(latDelta, longDelta)
        let theLocation  : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longtitude)
        let region : MKCoordinateRegion = MKCoordinateRegionMake(theLocation, span)
        map.setRegion(region, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

