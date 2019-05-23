//
//  AKConst.swift
//  BaseKit
//
//  Created by ldc on 2018/5/23.
//  Copyright © 2018年 Xiamen Hanin. All rights reserved.
//

import Foundation
import UIKit

public let WIDTH =  min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
public let HEIGHT = max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)

public var KeyWindow: UIWindow? {
    
    return  UIApplication.shared.keyWindow
}

public let DocumentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
public let CachesPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!

public func BKLog(_ item: Any?, file: String = #file, line: Int = #line) {
    
    let fileName = (file as NSString).lastPathComponent
    print("\(fileName)-\(line):\n\(item ?? "nil")")
}
