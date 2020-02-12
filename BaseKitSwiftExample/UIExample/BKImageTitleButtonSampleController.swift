//
//  BKImageTitleButtonSampleController.swift
//  BaseKitSwiftExample
//
//  Created by ldc on 2020/1/20.
//  Copyright © 2020 Xiamen Hanin. All rights reserved.
//

import UIKit
import BaseKitSwift

class BKImageTitleButtonSampleController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "图文按钮"
        view.backgroundColor = UIColor.white
        var buttons = [BKImageTitleButton]()
        let directions: [BKImageTitleButton.LayoutDirection] = [.vertical, .horizonal]
        let leadings: [BKImageTitleButton.ComponentType] = [.image, .title]
        let options: [BKImageTitleButton.LayoutOption] = [
            .leading(10),
            .center(10),
            .trailing(10),
            .leadingTrailing(10, 10)
        ]
        for direction in directions {
            for leading in leadings {
                for option in options {
                    let button = BKImageTitleButton.init(layoutDirection: direction, leadingComponentType: leading, layoutOption: option)
                    button.backgroundColor = UIColor.random
                    button.image = #imageLiteral(resourceName: "btn_pulldown")
                    button.titleLabel.text = "确定"
                    view.addSubview(button)
                    button.addTarget(self, action: #selector(self.buttonAction(sender:)), for: .touchUpInside)
                    buttons.append(button)
                }
            }
        }
        let size: CGFloat = 100
        for i in 0..<4 {
            for j in 0..<4 {
                buttons[i*4+j].tag = i*4+j
                buttons[i*4+j].snp.makeConstraints {
                    $0.centerX.equalToSuperview().offset((CGFloat(j)-1.5)*size)
                    $0.centerY.equalToSuperview().offset((CGFloat(i)-1.5)*size)
                    $0.width.height.equalTo(size)
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for temp in view.subviews {
            if let temp = temp as? BKImageTitleButton {
                temp.titleLabel.text = "确定确定"
            }
        }
    }
    
    @objc func buttonAction(sender: BKImageTitleButton) {
        
        print(sender.tag)
    }
}
