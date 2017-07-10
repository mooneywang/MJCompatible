//
//  ViewController.swift
//  MJCompatible
//
//  Created by Panda on 2017/7/10.
//  Copyright © 2017年 MooneyWang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let name = "http://www.baidu.com"
        print(name.mj.substring(to: 4))
        let url: NSString = "http://www.baidu.com"
        print(url.substring(to: 4))
        print(name.mj.substring(from: 7, to: 10))
    }
}


