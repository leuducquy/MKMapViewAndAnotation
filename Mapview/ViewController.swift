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
        // nho set  NSLocationAlwaysUsageDescription va NSLocationWhenInUseUsageDescription trong info.plist
        locations.delegate = self;
        // lay toa do tot nhat
        locations.desiredAccuracy = kCLLocationAccuracyBest;
        // luon luon request dia diem
        locations.requestAlwaysAuthorization()
        // bat dau cap nhat dia diem
        locations.startUpdatingLocation()
        let latitude : CLLocationDegrees   = 21.0103460
        let longtitude : CLLocationDegrees    = 105.8364969
        // xac dinh ti le zoom
        let latDelta : CLLocationDegrees = 0.0005    ;
        let longDelta : CLLocationDegrees  = 0.005;
        let span :MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        // gan vao dia diem
        let location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longtitude)
        // gan vao vung
        let region  : MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        // set vung cho map
        map.setRegion(region, animated: true)
        // khoi tao cay cot mau do?
        let anotation : MKPointAnnotation   = MKPointAnnotation()
        // gan toa do cho cay cot
        anotation.coordinate = location
        // gan tieu de
        anotation.title = "Ha noi"
        // gan tieu de phu
        anotation.subtitle = "i will be here"
       map.addAnnotation(anotation)
        // add tap 
        let tap = UITapGestureRecognizer(target: self, action: "action:")
        tap.numberOfTapsRequired = 1
        map.addGestureRecognizer(tap)
        // Do any additional setup after loading the view, typically from a nib.
    }
    func action(longPress : UIGestureRecognizer){
        let latDelta : CLLocationDegrees = 0.0005    ;
        let longDelta : CLLocationDegrees  = 0.005;
        let span :MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
       // lay diem tap
      let location  = longPress.locationInView(self.map)
        // convert diem tap sang kieu CLLocationCoordinate2D
        let newCoordiante = self.map.convertPoint(location, toCoordinateFromView: self.map)
        // lay vung tap
        let newregion : MKCoordinateRegion = MKCoordinateRegionMake(newCoordiante, span)
        // set vung tap cho map
        map.setRegion(newregion, animated: true)
        
        let newAnotation :MKPointAnnotation = MKPointAnnotation()
        newAnotation.coordinate = newCoordiante
        
        newAnotation.title = "Phu Quoc"
        newAnotation.subtitle = "I will be there"
        map.addAnnotation(newAnotation)

        print("anotation")
        
    }
    // update dia diem cua user tren ban do
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

