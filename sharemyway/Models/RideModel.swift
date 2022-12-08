//
//  Ride.swift
//  sharemyway
//
//  Created by Pavel Chernov on 16.11.2022.
//

import SwiftUI
import MapKit

struct RideModel: Identifiable {
    var id = UUID()
    var title: String
    var startPoint: String
    var destinationPoint: String
    var startPointCoord: CLLocationCoordinate2D
    var destinationPointCoord: CLLocationCoordinate2D
    var rideDate: Date
    var driver: String
    var creatorAvatar: String
    var creationDate: Date
}

//var rideList = [RideModel(title: "Ride number 1", startPoint: "Espoo, Karaportti 2", destinationPoint: "Helsinki, Aleksanterinkatu 1", startPointCoord: CLLocationCoordinate2D(latitude: 60.22378, longitude: 24.75826), destinationPointCoord: CLLocationCoordinate2D(latitude: 60.21378, longitude: 24.73826), rideDate: "14.12.2022", driver: NSFullUserName(), creatorAvatar: "driver", creationDate: "08.12.2022")
//]

var rideList: [RideModel] = []
