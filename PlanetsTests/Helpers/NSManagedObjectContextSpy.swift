//
//  NSManagedObjectContextSpy.swift
//  PlanetsTests
//
//  Created by Esraa Mohamed Ragab on 24/11/2021.
//

import Foundation
import CoreData
@testable import Planets

class NSManagedObjectContextSpy: NSManagedObjectContextProtocol {
    var fetchErrorToThrow: Error?
    var entitiesToReturn: [Any]?
    var addEntityToReturn: Any?
    var saveErrorToReturn: Error?
    var deletedObject: NSManagedObject?
    
    func allEntities<T: NSManagedObject>(withType type: T.Type) throws -> [T] {
        return try allEntities(withType: type, predicate: nil)
    }
    
    func allEntities<T: NSManagedObject>(withType type: T.Type, predicate: NSPredicate?) throws -> [T] {
        if let fetchErrorToThrow = fetchErrorToThrow {
            throw fetchErrorToThrow
        } else {
            return entitiesToReturn as! [T]
        }
    }
    
    func addEntity<T: NSManagedObject>(withType type : T.Type) -> T? {
        return addEntityToReturn as? T
    }
    
    func save() throws {
        if let saveErrorToReturn = saveErrorToReturn {
            throw saveErrorToReturn
        }
    }
    
    func delete(_ object: NSManagedObject) {
        deletedObject = object
    }
    
    func existingObject(with objectID: NSManagedObjectID) throws -> NSManagedObject {
        return NSManagedObject()
    }
    
}
