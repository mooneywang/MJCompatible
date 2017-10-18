//
//  ManagedObjectType.swift
//  MJCompatible
//
//  Created by Panda on 2017/10/18.
//  Copyright © 2017年 MooneyWang. All rights reserved.
//

import Foundation
import CoreData

protocol ManagedObjectType: class, NSFetchRequestResult {
    static var entityName: String { get }
    static var defaultSortDescriptors: [NSSortDescriptor] { get }
}

extension ManagedObjectType {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return []
    }

    static var sortedFetchRequest: NSFetchRequest<Self> {
        let request = NSFetchRequest<Self>(entityName: entityName)
        request.sortDescriptors = defaultSortDescriptors
        return request
    }
}

extension ManagedObjectType where Self: NSManagedObject {
    static var entityName: String {
        if #available(iOS 10.0, *) {
            return entity().name!
        } else {
            // Fallback on earlier versions
            return ""
        }
    }
}

