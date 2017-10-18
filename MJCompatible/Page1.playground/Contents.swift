//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let array1 = ["1", "2", "3", "4", "5", "6"]
let array2 = array1.map({ Int($0)! }).filter({ return $0 % 2 == 0 })
print(array1)
print(array2)

let str1 = "swift is amazing!"
String(str1.characters.prefix(5))

class Student: NSObject {
    let name: String
    let age: Int

    init(name n: String, age a: Int) {
        name = n
        age = a
    }
}

print(#keyPath(Student.name))