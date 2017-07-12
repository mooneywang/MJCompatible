//
//  UIImage+Compat.swift
//  MJCompatible
//
//  Created by Panda on 2017/7/12.
//  Copyright © 2017年 MooneyWang. All rights reserved.
//

import UIKit

extension UIImage: MJCompatible { }

extension Compat where Base: UIImage {

    func resizeTo(_ size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0) 
        base.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
