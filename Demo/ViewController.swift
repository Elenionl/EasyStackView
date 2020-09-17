//
//  ViewController.swift
//  Demo
//
//  Created by Elenion on 2020/4/2.
//  Copyright © 2020 Elenion. All rights reserved.
//

import UIKit
import EasyStackView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(stackView)
        stackView.frame = view.bounds
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            self.stackView.alignItems = .center
        }
        stackView.addTarget(self, action: #selector(didTapItem), for: .touchUpInside)
    }
    
    @objc func didTapItem() {
        print("item")
    }
    
    lazy var stackView: ESVStackControl = {
        let item = ESVStackControl()
        item.flexDirection = .row
        item.alignItems = .flexStart
        item.justifyContent = .flexStart
        item.spaceBetween = 10
        let container = ESVScrollView(frame: CGRect(x: 0, y: 0, width: 300, height: 700))
        container.backgroundColor = UIColor.yellow
        container.flexDirection = .row
        item.addArrangedItem(container)
        item.manageConfig(of: container) { (config) in
            config?.growth = true
        }
        item.backgroundColor = UIColor.red
        let view1 = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
        view1.backgroundColor = UIColor.blue
        container.addArrangedItem(view1)
        container.manageConfig(of: view1) { (config) in
            config?.margin = UIEdgeInsets(top: 100, left: 20, bottom: 20, right: 20)
            config?.shrink = true
            config?.growth = true
        }
        let view2 = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
        view2.backgroundColor = UIColor.green
        container.addArrangedItem(view2)
        container.manageConfig(of: view2) { (config) in
            config?.shrink = true
        }
        let view3 = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
        view3.backgroundColor = UIColor.purple
        container.addArrangedItem(view3)
        let view4 = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 400))
        view4.backgroundColor = UIColor.green
        item.addArrangedItem(view4)
        return item
    }()

}

