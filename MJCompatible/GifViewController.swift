//
//  GifViewController.swift
//  MJCompatible
//
//  Created by Panda on 2017/10/13.
//  Copyright © 2017年 MooneyWang. All rights reserved.
//

import UIKit

class GifViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.mj.loadGif(name: "niconiconi")
        imageView.mj.startGif(repeat: true)
    }
}
