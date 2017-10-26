//
//  AttributedStringViewController.swift
//  MJCompatible
//
//  Created by Panda on 2017/10/23.
//  Copyright © 2017年 MooneyWang. All rights reserved.
//

import UIKit

class AttributedStringViewController: UIViewController {

    @IBOutlet weak var codeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        print(UIFont.familyNames)


        let fontColor = UIColor(red: 103/255, green: 152/255, blue: 208/255, alpha: 1.0)
        let font = UIFont(name: "Hiragino Sans", size: 35) ?? UIFont()
        let attrDict: [String: Any] = [NSForegroundColorAttributeName: fontColor,
                                       NSFontAttributeName: font,
                                       NSKernAttributeName: 10]
        let attributedString = NSAttributedString(string: "9999", attributes: attrDict)


        codeLabel.attributedText = attributedString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
