//
//  ManagedObjectContextSettable.swift
//  MJCompatible
//
//  Created by Panda on 2017/10/18.
//  Copyright © 2017年 MooneyWang. All rights reserved.
//

import CoreData

protocol ManagedObjectContextSettable: class {
    var managedObjectContext: NSManagedObjectContext! { get set }
}
