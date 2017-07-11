//
//  UIImageView+Compat.swift
//  MJCompatible
//
//  Created by Panda on 2017/7/11.
//  Copyright © 2017年 MooneyWang. All rights reserved.
//

import UIKit

extension UIImageView: MJCompatible { }

extension Compat where Base: UIImageView {

    func setImageURL(url: URL, placeholder: UIImage? = nil) {

        // 设置占位图片
        base.image = placeholder

        let imageLoadSession = URLSession(configuration: .default)
        let imageLoadTask = imageLoadSession.dataTask(with: url) { (data, response, error) in

            if let data = data {
                DispatchQueue.main.async {
                    self.base.image = UIImage(data: data)
                }
            }

        }
        imageLoadTask.resume()
    }
}
