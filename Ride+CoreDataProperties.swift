//
//  Ride+CoreDataProperties.swift
//  sharemyway
//
//  Created by Marko Seppänen on 25.11.2022.
//
//

import Foundation
import CoreData


extension Ride {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ride> {
        return NSFetchRequest<Ride>(entityName: "Ride")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var rideDescription: String?
    @NSManaged public var startingPoint: String?
    @NSManaged public var endingPoint: String?
    @NSManaged public var date: Date?
    @NSManaged public var relationship: User?

}

extension Ride : Identifiable {

}
