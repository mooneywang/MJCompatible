//
//  Data+Compat.swift
//  MJCompatible
//
//  Created by Panda on 2017/7/26.
//  Copyright © 2017年 MooneyWang. All rights reserved.
//

import Foundation

private let pngHeader: [UInt8] = [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A]
private let jpgHeaderSOI: [UInt8] = [0xFF, 0xD8]
private let jpgHeaderIF: [UInt8] = [0xFF]
private let gifHeader: [UInt8] = [0x47, 0x49, 0x46]

enum ImageFormat {
    case Unknown, PNG, JPEG, GIF
}

extension NSData: MJCompatible {}

extension Compat where Base: NSData {
    var imageFormat: ImageFormat {
        var buffer = [UInt8](repeating: 0, count: 8)
        base.getBytes(&buffer, length: 8)
        if buffer == pngHeader {
            return .PNG
        } else if buffer[0] == jpgHeaderSOI[0] &&
            buffer[1] == jpgHeaderSOI[1] &&
            buffer[2] == jpgHeaderIF[0] {
            return .JPEG
        } else if buffer[0] == gifHeader[0] &&
            buffer[1] == gifHeader[1] &&
            buffer[2] == gifHeader[2] {
            return .GIF
        }
        return .Unknown
    }
}
