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
        view.backgroundColor = UIColor.white
        let control = ESVStackControl()
        control.alignItems = .center
        control.justifyContent = .center
        control.frame = CGRect(x: 100, y: 100, width: 200, height: 100)
        control.backgroundColor = .white
        self.view.addSubview(control)
        let item = ESVStackView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        item.backgroundColor = UIColor.red
        control.addArrangedItem(item)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        item.addArrangedItem(label)
        label.backgroundColor = UIColor.white
    }
}
