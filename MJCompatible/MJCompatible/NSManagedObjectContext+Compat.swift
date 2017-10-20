//
//  NSManagedObjectContext+Compat.swift
//  MJCompatible
//
//  Created by Panda on 2017/10/19.
//  Copyright © 2017年 MooneyWang. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext: MJCompatible { }

extension Compat where Base: NSManagedObjectContext {

    func insertObject<A: NSManagedObject>() -> A where A: ManagedObjectType {
        guard let obj = NSEntityDescription.insertNewObject(forEntityName: A.entityName, into: base) as? A else {
            fatalError("Wrong object type")
        }
        return obj
    }

    @discardableResult
    func saveOrRollback() -> Bool {
        do {
            try base.save()
            return true
        } catch {
            base.rollback()
            return false
        }
    }

    func performChanges(block: @escaping () -> ()) {
        base.perform {
            block()
            self.saveOrRollback()
        }
    }
}
