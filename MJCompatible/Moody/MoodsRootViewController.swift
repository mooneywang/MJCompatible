//
//  MoodsRootViewController.swift
//  MJCompatible
//
//  Created by Panda on 2017/10/18.
//  Copyright © 2017年 MooneyWang. All rights reserved.
//

import UIKit
import CoreData

class MoodsRootViewController: UIViewController, ManagedObjectContextSettable, SegueHandler {

    enum SegueIdentifier: String {
        case embedNavigation = "embedNavigationViewController"
        case embedCamera = "embedCameraViewController"
    }

    var managedObjectContext: NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .embedNavigation:
            print("embedNavigation")
        case .embedCamera:
            print("embedCamera")
        }
    }
}
