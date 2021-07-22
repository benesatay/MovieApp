//
//  Utilities.swift
//  mApp
//
//  Created by Bahadır Enes Atay on 17.07.2021.
//

import UIKit

#if DEBUG
func cLog(_ message: Any, filename: NSString = #file, function: String = #function, line: Int = #line) {
    print("[\(filename.lastPathComponent):\(line)] \(function) --> \(message)")
}
#else
func cLog(_ message: Any?, filename: NSString = #file, function: String = #function, line: Int = #line) {
}
#endif

