//: Playground - noun: a place where people can play

import UIKit
import Foundation

var str = "Hello, playground"

func isValidInput(Input:String) -> Bool {
    //let RegEx = "\\A\\w{6,18}\\z"
    let RegEx = "^(?=\\w{6,18})[a-zA-Z]\\w*(?:\\.\\w+)*(?:@\\w+\\.\\w{2,4})?$"
    let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)

    return Test.evaluate(with: Input)
}

print(isValidInput(Input:"brabra"))