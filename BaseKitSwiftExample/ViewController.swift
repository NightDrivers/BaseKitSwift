//
//  ViewController.swift
//  BaseKitSwiftExample
//
//  Created by ldc on 2019/5/24.
//  Copyright © 2019 Xiamen Hanin. All rights reserved.
//

import UIKit
import BaseKitSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.init(white: 0.9, alpha: 1)
        label.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.centerY.equalTo(self.snp.centerY)
            $0.height.equalTo(label.font.lineHeight)
        }
        view1.snp.makeConstraints {
            $0.left.equalTo(label.snp.right)
            $0.centerY.equalTo(label.snp.centerY)
            $0.height.equalTo(label.snp.height)
            $0.right.equalToSuperview()
        }
        label2.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.top.equalTo(label.snp.bottom)
            $0.height.equalTo(label.font.lineHeight)
            $0.width.equalTo(label.snp.width)
        }
        view2.snp.makeConstraints {
            $0.left.equalTo(label2.snp.right)
            $0.top.equalTo(label.snp.bottom)
            $0.height.equalTo(label2.snp.height)
            $0.right.equalToSuperview()
        }
        button.snp.makeConstraints {
            $0.top.equalTo(label2.snp.bottom)
            $0.height.equalTo(button.titleLabel!.font.lineHeight)
            $0.centerX.equalToSuperview()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let action = UIAlertAction(title: "确定", style: .default, handler: nil)
        bk_presentAlertController(title: "提示", message: "message", preferredStyle: .alert, actions: [action])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(label.frame)
    }
    
    lazy var view1: UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor.random
        view.addSubview(temp)
        return temp
    }()
    
    lazy var label: UILabel = {
        let temp = UILabel()
        temp.text = "爱发的看法"
        temp.textAlignment = .center
        temp.font = UIFont.systemFont(ofSize: 11)
        view.addSubview(temp)
        return temp
    }()
    
    lazy var view2: UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor.random
        view.addSubview(temp)
        return temp
    }()
    
    lazy var label2: UILabel = {
        let temp = UILabel()
        temp.text = "爱发的看法阿斯顿发"
        temp.textAlignment = .center
        temp.font = UIFont.systemFont(ofSize: 11)
        view.addSubview(temp)
        return temp
    }()
    
    lazy var button: UIButton = {
        let temp = UIButton.init(type: .custom)
        temp.setTitle("这是一个按钮啊剪短发了", for: .normal)
        temp.setTitleColor(UIColor.random, for: .normal)
        temp.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        temp.setImage(#imageLiteral(resourceName: "btn_pulldown"), for: .normal)
        temp.layer.borderWidth = 1
        temp.layer.borderColor = UIColor.random.cgColor
        view.addSubview(temp)
        return temp
    }()
}

