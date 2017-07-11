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

        let tableVC = UITableViewController()
        tableVC.view.frame = CGRect(x: 0, y: 0, width: 320, height: 667)
        self.view.addSubview(tableVC.view)
        self.addChildViewController(tableVC)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let vc = UIViewControllerProxy.topMost(of: self) {
            print(vc)
        }
    }
}


