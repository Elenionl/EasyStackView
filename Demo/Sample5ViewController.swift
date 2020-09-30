//
//  Sample5ViewController.swift
//  Demo
//
//  Created by Elenion on 2020/9/29.
//  Copyright © 2020 Elenion. All rights reserved.
//

import UIKit
import EasyStackView

class Sample5ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let control = ESVStackControl()
        control.alignItems = .center
        control.justifyContent = .center
        control.frame = CGRect(x: 100, y: 100, width: 200, height: 100)
        control.backgroundColor = .white
        self.view.addSubview(control)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 13, height: 20))
        label.backgroundColor = UIColor.red
        control.addArrangedItem(label)
        control.manageConfig(of: label) { (config) in
            config?.originSize = CGSize(width: 50, height: 50)
        }
    }
}
