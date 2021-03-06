//
//  BKStringExtension.swift
//  BaseKit
//
//  Created by ldc on 2018/5/23.
//  Copyright © 2018年 Xiamen Hanin. All rights reserved.
//

import UIKit
import CommonCrypto

public enum AKError: Error {
    case hexStringToDataOverflowoutCharacter
    case irregularHexString
}

public extension String {
    
    /// 获取字符串绘制高度
    ///
    /// - Parameters:
    ///   - width: 绘制区域宽度
    ///   - font: 绘制字体
    /// - Returns: 绘制的高度
    func drawHeight(with width: CGFloat, font: UIFont) -> CGFloat {
        
        let size = CGSize.init(width: width, height: CGFloat.greatestFiniteMagnitude)
        let rect = (self as NSString).boundingRect(with: size, options: [.usesFontLeading,.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : font], context: nil)
        return ceil(rect.height) + 1
    }
    
    /// 获取字符串单行绘制宽度
    ///
    /// - Parameter font: 字体
    /// - Returns: 返回宽度
    func drawWidth(with font: UIFont) -> CGFloat {
        
        let size = CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: font.lineHeight)
        let rect = (self as NSString).boundingRect(with: size, options: [.usesFontLeading,.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : font], context: nil)
        return ceil(rect.width) + 1
    }
}

public extension String {
    
    /// 将十六进制字符串转为数据流,必须为 12 34 ef ab 这种格式，每组为两个十六进制字符，中间用空格隔开
    ///
    /// - Returns: 数据流
    /// - Throws: 字符串存在非十六进制字符错误
    func hexStringToData() throws -> Data {
        
        if !isRegularHexString {
            throw AKError.irregularHexString
        }
        var data = Data()
        var temp = self.replacingOccurrences(of: "/n", with: "")
        temp = temp.replacingOccurrences(of: "/r", with: "")
        temp = temp.replacingOccurrences(of: " ", with: "")
        for i in 0..<temp.count/2 {
            let sub = (temp as NSString).substring(with: NSRange.init(location: 2*i, length: 2))
            if let result = UInt8(sub,radix: 16) {
                data.append(result)
            }else {
                throw AKError.hexStringToDataOverflowoutCharacter
            }
        }
        return data
    }
}

public extension String {
    
    //是否是规则的十六进制字符串，"12 54 ef"格式
    var isRegularHexString: Bool {
        
        let regularString = "^[ \\n\\r]*([0-9a-fA-F]{2}[ \\n\\r]+)*([0-9a-fA-F]{2})*$"
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", regularString)
        return predicate.evaluate(with: self)
    }
    
    var isPhoneNo: Bool {
        
        let pattern = "^((13[0-9])|(14[579])|(15[0-3,5-9])|166|(17[0-1,3,5-9])|(18[0-9])|(19[89]))\\d{8}$"
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", pattern)
        return predicate.evaluate(with: self)
    }
    
    var isIp: Bool {
        let numPre = "(2[0-4]\\d|25[0-5]|[01]?\\d\\d?)"
        let rex = String.init(format: "^(%@.){3}%@$", numPre, numPre)
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", rex)
        return predicate.evaluate(with: self)
    }
}

public extension String {
    
    var md5: String {
        
        return self.data(using: .utf8)!.md5
    }
    
    var sha1: String {
        
        return self.data(using: .utf8)!.sha1
    }
}

public extension String {
    
    subscript(i: ClosedRange<Int>) -> Substring {
        
        let start = self.index(self.startIndex, offsetBy: i.lowerBound)
        let end = self.index(self.startIndex, offsetBy: i.upperBound)
        return self[start...end]
    }
}

public enum Language: Int {
    
    case none = 0, en, zh_Hans, ja
}

public extension String {
    
    static var lang = Language.none
    
    var localized: String {
        
        switch String.lang {
        case .none:
            return Bundle.main.localizedString(forKey: self, value: nil, table: nil)
        case .zh_Hans:
            return Bundle.main.localizedString(forKey: self, value: nil, table: "zh-Hans.lproj/Localizable")
        case .ja:
            return Bundle.main.localizedString(forKey: self, value: nil, table: "ja.lproj/Localizable")
        case .en:
            return Bundle.main.localizedString(forKey: self, value: nil, table: "en.lproj/Localizable")
        }
    }
    
    static let languageChanged = Notification.Name("string.language.did.change")
}
