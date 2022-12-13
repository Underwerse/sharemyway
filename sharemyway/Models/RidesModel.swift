//
//  RideModel.swift
//  sharemyway
//
//  Created by Pavel Chernov on 11.12.2022.
//
import SwiftUI
import MapKit

struct RidesModel {
    var documentID: String
    var title: String
    var driver: String
    var creatorPhone: String
    var startPoint: String
    var destinationPoint: String
    var startPointCoord: CLLocationCoordinate2D
    var destinationPointCoord: CLLocationCoordinate2D
    var rideDate: Date
    var creationDate: Date
}
