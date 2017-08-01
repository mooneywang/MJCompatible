//
//  ViewController.swift
//  MJCompatible
//
//  Created by Panda on 2017/7/10.
//  Copyright © 2017年 MooneyWang. All rights reserved.
//

import UIKit
import ImageIO

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: "http://mooneywang.github.io/uploads/avatar.png") {

            // 加载网络图片
            imageView.mj.setImageURL(url: url, placeholder: UIImage(named: "ad01"))
        }

        // 显示GIF
        secondImageView.mj.gif(name: "niconiconi")
    }

}


