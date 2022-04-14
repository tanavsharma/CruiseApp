//
//  LocationsDataService.swift
//  MapTest
//
//  Created by Nick Sarno on 11/26/21.
//

import Foundation
import MapKit

class LocationsDataService {
    
    static let locations: [Location] = [
        
        Location(
            name: "CN Tower Cruise",
            cityName: "Toronto",
            coordinates: CLLocationCoordinate2D(latitude: 43.642567, longitude: -79.387054),
            description: "We pride ourselves in providing the best service to all our customers. Call us today, to plan your next get away. Leave the headaches to us! ",
            imageName: "cntower"),
        
        Location(
            name: "Niagara Falls Cruise",
            cityName: "Toronto",
            coordinates: CLLocationCoordinate2D(latitude: 43.082817, longitude: -79.074165),
            description: "We pride ourselves in providing the best service to all our customers. Call us today, to plan your next get away. Leave the headaches to us! ",
            imageName: "niagarafalls")
    ]
    
}
