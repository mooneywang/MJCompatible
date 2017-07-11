//
//  ViewController.swift
//  MJCompatible
//
//  Created by Panda on 2017/7/10.
//  Copyright © 2017年 MooneyWang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: "http://mooneywang.github.io/uploads/avatar.png") {
            imageView.mj.setImageURL(url: url, placeholder: UIImage(named: "ad01"))
        }
    }

}


