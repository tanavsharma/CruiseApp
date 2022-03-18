//
//  Location.swift
//  CruiseApp
//
//  Created by Tanav Sharma on 2022-03-17.
//

import Foundation
import MapKit


// MARK: Every location must have the following

struct Location: Identifiable, Equatable {

    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let description: String
    let imageName: String
    
    var id: String{
        name + cityName
    }
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
    
    

}
