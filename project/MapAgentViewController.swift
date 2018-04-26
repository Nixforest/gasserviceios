//
//  MapAgentViewController.swift
//  project
//
//  Created by Lâm Phạm on 4/23/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import MapKit
import harpyframework

class MapAgentViewController: BaseParentViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    var record: MapAgentResponse!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        toCurrentLocation()
//        locationManager.requestWhenInUseAuthorization()
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
//            locationManager.startUpdatingLocation()
//        }
        requestMapAgent()
    }
    
    func toCurrentLocation() {
        locationManager.requestWhenInUseAuthorization()
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
        
        let spanX = 0.075
        let spanY = 0.075
//        var location:CLLocation = locationManager.location!
//        var coordinate:CLLocationCoordinate2D = location.coordinate
        let coordinate = CLLocationCoordinate2D(latitude: 10.816524, longitude: 106.672014)
        let newRegion = MKCoordinateRegion(center:coordinate , span: MKCoordinateSpanMake(spanX, spanY))
        mapView.setRegion(newRegion, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadAgent(listAgent: [AgentInfoBean]) {
        for agent in listAgent {
            let annotation = MKPointAnnotation()
            let lat = Double(agent.info_agent.agent_latitude.trimmingCharacters(in: .whitespaces))
            let long = Double(agent.info_agent.agent_longitude.trimmingCharacters(in: .whitespaces))
            annotation.coordinate = CLLocationCoordinate2D(latitude: lat!, longitude: long!)
            mapView.addAnnotation(annotation)
        }
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationIdentifier = "AgentAnnotation"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView!.canShowCallout = true
        }
        else {
            annotationView!.annotation = annotation
        }
        var pinImage = UIImage()
        if annotation.isKind(of: MKUserLocation.self) {
            pinImage = ImageManager.getImage(named: DomainConst.GAS24H_USER_ANNOTAION)!
        } else {
            pinImage = ImageManager.getImage(named: DomainConst.GAS24H_AGENT_ANNOTATION)!
        }
        let size = CGSize(width: 20, height: 30)
        UIGraphicsBeginImageContext(size)
        pinImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        annotationView?.image = resizedImage
        annotationView?.contentMode = .scaleAspectFit
        return annotationView
    }
    
    /**
     * Request Map Agent
     */
    private func requestMapAgent() {
        MapAgentRequest.request(action: #selector(finishMapAgentRequest(_:)), view: self, id: "")
    }
    
    /**
     * Handler when order config request is finish
     */
    internal func finishMapAgentRequest(_ notification: Notification) {
        let data = (notification.object as! String)
        record = MapAgentResponse(jsonString: data)
        loadAgent(listAgent: record.listAgent)
        if record.isSuccess() {

        } else {

        }
    }

}
