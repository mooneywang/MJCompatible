//
//  Mood.swift
//  MJCompatible
//
//  Created by Panda on 2017/10/18.
//  Copyright © 2017年 MooneyWang. All rights reserved.
//

import UIKit
import CoreData

final class Mood: NSManagedObject {

    @NSManaged private(set) var date: Date
    @NSManaged private(set) var colors: [UIColor]

    @discardableResult
    static func insert(into context: NSManagedObjectContext, image: UIImage) -> Mood {
        let mood: Mood = context.mj.insertObject()
        mood.colors = [.red]
        mood.date = Date()
        return mood
    }

}

extension Mood: ManagedObjectType {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(date), ascending: false)]
    }
}
