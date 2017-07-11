//
//  MJCompatible.swift
//  MJCompatible
//
//  Created by Panda on 2017/7/10.
//  Copyright © 2017年 MooneyWang. All rights reserved.
//

import Foundation

public final class Compat<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol MJCompatible {
    associatedtype CompatibleType
    var mj: CompatibleType { get }
}

public extension MJCompatible {
    public var mj: Compat<Self> {
        get {
            return Compat(self)
        }
    }
}
