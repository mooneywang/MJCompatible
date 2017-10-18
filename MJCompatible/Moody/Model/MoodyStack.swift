//
//  MoodyStack.swift
//  MJCompatible
//
//  Created by Panda on 2017/10/18.
//  Copyright © 2017年 MooneyWang. All rights reserved.
//

import CoreData

func createMoodyContainer(completion: @escaping (NSPersistentContainer) -> ()) {
    let container = NSPersistentContainer(name: "Moody")
    container.loadPersistentStores { _, error in
        guard error == nil else {
            fatalError("Failed to load store: \(String(describing: error))")
        }
        DispatchQueue.main.async {
            completion(container)
        }
    }
}
