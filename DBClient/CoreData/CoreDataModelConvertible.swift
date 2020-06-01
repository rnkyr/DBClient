//
//  CoreDataModelConvertible.swift
//  DBClient
//
//  Created by Roman Kyrylenko on 30.05.2020.
//

import CoreData

/// Describes type of model for CoreData database client.
/// Model should conform to CoreDataModelConvertible protocol
/// for ability to be fetched/saved/updated/deleted in CoreData
public protocol CoreDataModelConvertible: Stored {
    
    /// Returns type of object for model.
    static func managedObjectClass() -> NSManagedObject.Type
    
    /// Executes mapping from `NSManagedObject` instance.
    ///
    /// - Parameter managedObject: object to be mapped from.
    /// - Returns: mapped object.
    static func from(_ managedObject: NSManagedObject) -> Stored
    
    /// Executes backward mapping to `NSManagedObject` from given context
    ///
    /// - Parameters:
    ///   - context: context, where object should be created;
    ///   - existedInstance: if instance was already created it will be passed.
    /// - Returns: created instance.
    func upsertManagedObject(in context: NSManagedObjectContext, existedInstance: NSManagedObject?) -> NSManagedObject
    
    /// The name of the entity from ".xcdatamodeld"
    static var entityName: String { get }
    
    /// Decides whether primary value of object equal to given
    func isPrimaryValueEqualTo(value: Any) -> Bool
}

extension CoreDataModelConvertible {
    
    public static func extractModel<T: CoreDataModelConvertible>(from managedObject: NSManagedObject?) -> T? {
        if let object = managedObject {
            return T.from(object) as? T
        }
        
        return nil
    }

    public static func extractModel<T: CoreDataModelConvertible>(from managedObject: NSManagedObject) -> T {
        guard let object = T.from(managedObject) as? T else {
            fatalError("Can't convert \(managedObject) to \(T.self)")
        }
        
        return object
    }

    public static func upsertingManagedObject<T: NSManagedObject, V: CoreDataModelConvertible>(
        of type: V.Type,
        in context: NSManagedObjectContext,
        with existedInstance: NSManagedObject?
    ) -> T {
        let object: T
        if let existedInstance = existedInstance {
            if let existedInstance = existedInstance as? T {
                object = existedInstance
            } else {
                fatalError("Can't cast given `NSManagedObject`: \(existedInstance) to `\(V.self)`")
            }
        } else {
            let managedObject = NSEntityDescription.insertNewObject(forEntityName: V.entityName, into: context)
            if let managedObject = managedObject as? T {
                object = managedObject
            } else {
                fatalError("Inserted object type is not `\(T.self)`")
            }
        }
        return object
    }
}
