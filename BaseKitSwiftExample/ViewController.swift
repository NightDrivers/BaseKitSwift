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
    
    struct ActionItem {
        var title: String
        var action: (() -> Void)?
    }
    
    var actions = [ActionItem]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "主页"
        initActions()
        tableView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top)
            $0.bottom.right.left.equalToSuperview()
        }
    }
    
    func initActions() -> Void {
        
        var action = ActionItem.init(title: "图文按钮") { [weak self] in
            let temp = BKImageTitleButtonSampleController()
            self?.push(temp)
        }
        actions.append(action)
        
        action = ActionItem.init(title: "测试") {
            var data = Data.init([0x12, 0x34])
            let length: UInt16 = 0x7856
            let lengthData = Data.create(length, as: UInt16.self)
            data.append(lengthData)
            data.append(0x56341290, as: UInt32.self)
            data.append(0, as: UInt64.self)
            data.storeBytes(0x1290785634129078, toByteOffset: 8, as: UInt64.self)
            print(data.hexString)
        }
        actions.append(action)
    }
    
    func push(_ temp: UIViewController) -> Void {
        
        temp.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(temp, animated: true)
    }
    
    lazy var tableView: UITableView = {
        let temp = UITableView(frame: .zero, style: .grouped)
        temp.delegate = self
        temp.dataSource = self
        view.addSubview(temp)
        return temp
    }()
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return nil
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return actions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "iden")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "iden")
        }
        let action = actions[indexPath.row]
        cell?.textLabel?.text = action.title
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        if let action = actions[indexPath.row].action {
            action()
        }
    }
}
