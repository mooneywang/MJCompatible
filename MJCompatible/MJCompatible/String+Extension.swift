//
//  String+Extension.swift
//  MJCompatible
//
//  Created by Panda on 2017/7/10.
//  Copyright © 2017年 MooneyWang. All rights reserved.
//

import Foundation

public struct StringProxy {
    fileprivate let base: String
    init(proxy: String) {
        base = proxy
    }
}

extension String: MJCompatible {
    public typealias CompatibleType = StringProxy
    public var mj: StringProxy {
        return StringProxy(proxy: self)
    }
}

extension StringProxy {

    func length() -> Int {
        return base.characters.count
    }

    func substring(from: Int) -> String {
        let index = base.index(base.startIndex, offsetBy: from)
        return base.substring(from: index)
    }

    func substring(to: Int) -> String {
        let index = base.index(base.startIndex, offsetBy: to)
        return base.substring(to: index)
    }

    func substring(from: Int, to: Int) -> String {
        let startIndex = base.index(base.startIndex, offsetBy: from)
        let endIndex = base.index(base.startIndex, offsetBy: to)
        let range = Range(uncheckedBounds: (lower: startIndex, upper: endIndex))
        return base.substring(with: range)
    }

    func base64Encoding() -> String? {
        let data = base.data(using: .utf8)
        return data?.base64EncodedString()
    }
}
