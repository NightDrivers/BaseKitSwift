//
//  UITextFieldExtension.swift
//  BaseKit
//
//  Created by ldc on 2019/5/17.
//  Copyright © 2019 Xiamen Hanin. All rights reserved.
//

import Foundation

public extension UITextField {
    
    static func swizzle() {
        
        let originSelectors = [
            #selector(self.leftViewRect(forBounds:)),
            #selector(self.textRect(forBounds:)),
            #selector(self.editingRect(forBounds:))
        ]
        let newSelectors = [
            #selector(self.ap_leftViewRect(forBounds:)),
            #selector(self.ap_textRect(forBounds:)),
            #selector(self.ap_editingRect(forBounds:))
        ]
        
        for i in 0..<originSelectors.count {
            
            if let originMethod = class_getInstanceMethod(self, originSelectors[i]), let newMethod = class_getInstanceMethod(self, newSelectors[i]) {
                method_exchangeImplementations(originMethod, newMethod)
            }
        }
    }
    
    fileprivate struct Key {
        
        static var leftViewRectKey = 0
        static var leftTextMargin = 0
    }
    
    var leftViewRect: CGRect? {
        
        set {
            objc_setAssociatedObject(self, &Key.leftViewRectKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        
        get {
            return objc_getAssociatedObject(self, &Key.leftViewRectKey) as? CGRect
        }
    }
    
    var leftTextMargin: CGFloat? {
        
        set {
            objc_setAssociatedObject(self, &Key.leftTextMargin, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        
        get {
            return objc_getAssociatedObject(self, &Key.leftTextMargin) as? CGFloat
        }
    }
    
    @objc func ap_leftViewRect(forBounds bounds: CGRect) -> CGRect {
        
        if let leftViewRect = leftViewRect {
            return leftViewRect
        }else {
            return ap_leftViewRect(forBounds: bounds)
        }
    }
    
    @objc func ap_textRect(forBounds bounds: CGRect) -> CGRect {
        
        if let leftTextMargin = leftTextMargin {
            
            var rect = ap_textRect(forBounds: bounds)
            rect.origin.x += leftTextMargin
            rect.size.width -= leftTextMargin
            return rect
        }else {
            return ap_textRect(forBounds: bounds)
        }
    }
    
    @objc func ap_editingRect(forBounds bounds: CGRect) -> CGRect {
        
        if let leftTextMargin = leftTextMargin {
            
            var rect = ap_editingRect(forBounds: bounds)
            rect.origin.x += leftTextMargin
            rect.size.width -= leftTextMargin
            return rect
        }else {
            return ap_editingRect(forBounds: bounds)
        }
    }
}
