//
//  UIImageView+Compat.swift
//  MJCompatible
//
//  Created by Panda on 2017/7/11.
//  Copyright © 2017年 MooneyWang. All rights reserved.
//

import UIKit
import ImageIO

extension UIImageView: MJCompatible { }

extension Compat where Base: UIImageView {

    func setImageURL(url: URL, placeholder: UIImage? = nil) {

        // 设置占位图片
        base.image = placeholder

        let imageLoadSession = URLSession(configuration: .default)
        let imageLoadTask = imageLoadSession.dataTask(with: url) { (data, response, error) in

            if let data = data {
                DispatchQueue.main.async {
                    self.base.image = UIImage(data: data)?.mj.resizeTo(CGSize(width: 50, height: 50))
                }
            }

        }
        imageLoadTask.resume()
    }

    func gif(name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "gif") else {
            return
        }
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            return
        }
        var images: [UIImage] = []
        var duration: TimeInterval = 0
        for i in 0..<CGImageSourceGetCount(source) {
            if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(UIImage(cgImage: cgImage))
            }
            duration += self.durationForImageAtIndex(source, index: i)
        }
        self.base.animationImages = images
        self.base.animationDuration = duration
        self.base.startAnimating()
    }

    private func durationForImageAtIndex(_ source: CGImageSource, index: Int) -> TimeInterval {
        var delay = 0.1
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifPropertiesPointer = UnsafeMutablePointer<UnsafeRawPointer?>.allocate(capacity: 0)
        if CFDictionaryGetValueIfPresent(cfProperties, Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque(), gifPropertiesPointer) {
            let gifProperties: CFDictionary = unsafeBitCast(gifPropertiesPointer.pointee, to: CFDictionary.self)
            let delayObjectPointer = CFDictionaryGetValue(gifProperties, Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque())
            let delayObject = unsafeBitCast(delayObjectPointer, to: AnyObject.self)
            delay = delayObject.doubleValue
        }
        return delay
    }
}
