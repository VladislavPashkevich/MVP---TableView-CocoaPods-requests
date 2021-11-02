//
//  Categories+CoreDataClass.swift
//  
//
//  Created by Vladislav Pashkevich on 26.10.21.
//
//

import Foundation
import CoreData

@objc(Categories)
public class Categories: NSManagedObject, Identifiable {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Categories> {
        return NSFetchRequest<Categories>(entityName: "Categories")
    }

    @NSManaged public var note: String

}
