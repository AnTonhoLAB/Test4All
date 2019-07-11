//
//  BindablesObjects.swift
//  Test4All
//
//  Created by George Gomes on 11/07/19.
//  Copyright © 2019 George Gomes. All rights reserved.
//

import UIKit
import MapKit

extension UIImageView: Bindable {
    public typealias BindingType = Data
    
    public func observingValue() -> Data {
        return (self.image?.pngData()!)!
    }
    
    public func updateValue(with value: Data) {
        self.image = UIImage(data: value)
    }
}

extension MKMapView: Bindable {
    
    public typealias BindingType = CLLocation
    
    public func observingValue() -> CLLocation {
        return CLLocation()
    }
    
    public func updateValue(with value: CLLocation) {
        self.centerMapOnLocation(location: value)
    }
    
    func centerMapOnLocation(location: CLLocation) {
        
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        self.setRegion(coordinateRegion, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        self.addAnnotation(annotation)
    }
}


