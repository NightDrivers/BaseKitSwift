//
//  BKKeyboardAutoAdjust.swift
//  SwiftTest
//
//  Created by ldc on 2018/9/17.
//  Copyright © 2018年 Xiamen Hanin. All rights reserved.
//

import UIKit

public class BKKeyboardAutoAdjust: NSObject {

    var editingViewFrame = CGRect.zero
    
    public static let share = BKKeyboardAutoAdjust()
    
    fileprivate override init() {
        super.init()
    }
    
    public func beginMonitoredEditing(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notify:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.textFieldDidBeginEditing(notify:)), name: UITextField.textDidBeginEditingNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notify:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    public func stopMonitoredEditing() -> Void {
        
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notify: Notification) {
        
        guard let value = notify.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let frame = value.cgRectValue
        if frame.intersects(self.editingViewFrame) {
            UIApplication.shared.keyWindow?.frame = CGRect.init(x: 0, y: frame.minY - self.editingViewFrame.maxY, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }
    }
    
    @objc func keyboardWillHide(notify: Notification) {
        
        self.editingViewFrame = .zero
        UIApplication.shared.keyWindow?.frame = UIScreen.main.bounds
    }
    
    @objc func textFieldDidBeginEditing(notify: Notification) {
        
        guard let textField = notify.object as? UITextField else { return }
        guard let superView = textField.superview else { return }
        guard let frame = UIApplication.shared.keyWindow?.convert(textField.frame, from: superView) else { return }
        self.editingViewFrame = frame
    }
    
}
