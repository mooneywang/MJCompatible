//
//  MJCompatible.swift
//  MJCompatible
//
//  Created by Panda on 2017/7/10.
//  Copyright © 2017年 MooneyWang. All rights reserved.
//

import Foundation

public protocol MJCompatible {
    associatedtype CompatibleType
    var mj: CompatibleType { get }
}
