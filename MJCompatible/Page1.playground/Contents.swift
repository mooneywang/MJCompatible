//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let array1 = ["1", "2", "3", "4", "5", "6"]
let array2 = array1.map({ Int($0)! }).filter({ return $0 % 2 == 0 })
print(array1)
print(array2)