//
//  PersistenceController.swift
//  sharemyway
//
//  Created by Pavel Chernov on 12.12.2022.
//

import Foundation
import CoreData
import MapKit

struct PersistenceController {
    // A singleton for entire app to use
    static let shared = PersistenceController()

    // Storage for Core Data
    let container: NSPersistentContainer

    // A test configuration for SwiftUI previews
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)

        return controller
    }()

    // An initializer to load Core Data, optionally able
    // to use an in-memory store.
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "RideModel")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func addRide(title: String, driver: String, creatorAvatar: String, startPoint: String, destinationPoint: String, startPointCoordLat: Double, startPointCoordLon: Double, destinationPointCoordLat: Double, destinationPointCoordLon: Double, rideDate: Date, creationDate: Date, context: NSManagedObjectContext) {
        
        let ride = Ride(context: container.viewContext)
        
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
        
//        print("SAVE to context")
//        save()
    }
    
    func save() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Show some error here
                print("Save context error")
            }
        }
    }
    
    func deleteAllData(_ entity:String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try PersistenceController.shared.container.viewContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                PersistenceController.shared.container.viewContext.delete(objectData)
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }
}
