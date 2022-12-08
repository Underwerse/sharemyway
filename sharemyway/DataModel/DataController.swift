//
//  DataController.swift
//  sharemyway
//
//  Created by Pavel Chernov on 8.12.2022.
//

import Foundation
import CoreData
import MapKit

class DataController: ObservableObject {
    var container = NSPersistentContainer(name: "RideModel")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved")
        } catch {
            print("Could not save data")
        }
    }
    
    func addRide(title: String, driver: String, creatorAvatar: String, startPoint: String, destinationPoint: String, startPointCoordLat: Double, startPointCoordLon: Double, destinationPointCoordLat: Double, destinationPointCoordLon: Double, rideDate: Date, creationDate: Date, context: NSManagedObjectContext) {
        
        let ride = Ride(context: context)
        
        print("ride date to add: \(rideDate)")
        
        ride.id = UUID()
        ride.title = title
        ride.driver = driver
        ride.creatorAvatar = creatorAvatar
        ride.startPoint = startPoint
        ride.destinationPoint = destinationPoint
        ride.startPointCoordLat = startPointCoordLat
        ride.startPointCoordLon = startPointCoordLon
        ride.destinationPointCoordLat = destinationPointCoordLat
        ride.destinationPointCoordLon = destinationPointCoordLon
        ride.rideDate = rideDate
        ride.creationDate = creationDate
    }
    
    
}
