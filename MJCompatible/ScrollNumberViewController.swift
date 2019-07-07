//
//  ScrollNumberViewController.swift
//  MJCompatible
//
//  Created by 王梦杰 on 2019/7/7.
//  Copyright © 2019 MooneyWang. All rights reserved.
//

import UIKit

class ScrollNumberViewController: UIViewController {
    
    private weak var scrollNumLabel: DPScrollNumberLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let numLabel = DPScrollNumberLabel(number: NSNumber(value: 1000),
                                           font: UIFont.systemFont(ofSize: 20))!
        numLabel.frame = CGRect(x: 16, y: 100, width: self.view.bounds.width - 32, height: 22)
        self.view.addSubview(numLabel)
        self.scrollNumLabel = numLabel
        self.scrollNumLabel.backgroundColor = UIColor.yellow
        self.scrollNumLabel.change(to: NSNumber(value: 2046), animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
