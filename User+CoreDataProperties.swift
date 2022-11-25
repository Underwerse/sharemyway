//
//  User+CoreDataProperties.swift
//  sharemyway
//
//  Created by Marko Seppänen on 25.11.2022.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var isRider: Bool
    @NSManaged public var relationship: Ride?

}

extension User : Identifiable {

}
