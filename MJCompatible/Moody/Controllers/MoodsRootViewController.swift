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
        case embedTable = "embedTableViewController"
        case embedCamera = "embedCameraViewController"
    }

    var managedObjectContext: NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .embedTable:
            print("embedTable")
        case .embedCamera:
            guard let vc = segue.destination as? MoodsCameraViewController else {
                fatalError("must be MoodsCameraViewController")
            }
            vc.delegate = self
        }
    }
}

extension MoodsRootViewController: MoodsCameraViewControllerDelegate {

    func didCapture(_ image: UIImage?) {
        print("didCapture \(image!)")
    }
}