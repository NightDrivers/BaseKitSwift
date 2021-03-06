//
//  BKAuthorizationExtension.swift
//  BaseKit
//
//  Created by ldc on 2018/9/5.
//  Copyright © 2018年 Xiamen Hanin. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation
import Photos

public extension AVCaptureDevice {
    
    static func requestCameraAuthorization(closure: @escaping () -> Void) {
        
        let authorization = self.authorizationStatus(for: .video)
        switch authorization {
        case .authorized:
            closure()
        case .denied,.restricted:
            KeyWindow?.rootViewController?.bk_presentDecisionAlertController(title: "提示".localized, message: "请您设置允许该应用访问您的相机\n设置>隐私>相机".localized, decisionTitle: "去设置".localized, decisionClosure: { (_) in
                guard let url = URL.init(string: UIApplication.openSettingsURLString) else { return }
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }else {
                    UIApplication.shared.openURL(url)
                }
            })
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (authored) in
                if authored {
                    DispatchQueue.main.async {
                        closure()
                    }
                }
            })
        @unknown default:
            fatalError("never execute")
        }
    }
}

public extension PHPhotoLibrary {
    
    static func requestPhotoAuthorization(closure: @escaping () -> Void) {
        
        let authorization = PHPhotoLibrary.authorizationStatus()
        switch authorization {
        case .authorized:
            closure()
        case .denied,.restricted:
            KeyWindow?.rootViewController?.bk_presentDecisionAlertController(title: "提示".localized, message: "请您设置允许该应用访问您的照片\n设置>隐私>照片".localized, decisionTitle: "去设置".localized, decisionClosure: { (_) in
                guard let url = URL.init(string: UIApplication.openSettingsURLString) else { return }
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }else {
                    UIApplication.shared.openURL(url)
                }
            })
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ (status) in
                DispatchQueue.main.async {
                    if status == .authorized {
                        closure()
                    }
                }
            })
        @unknown default:
            fatalError("never execute")
        }
    }
}
