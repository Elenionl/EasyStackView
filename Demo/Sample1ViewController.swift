//
//  Sample1ViewController.swift
//  Demo
//
//  Created by Elenion on 2020/7/20.
//  Copyright © 2020 Elenion. All rights reserved.
//

import UIKit
import EasyStackView

class Sample1ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let container = ESVStackView(frame: view.bounds)
        container.backgroundColor = UIColor.red
        container.justifyContent = .spaceAround
        container.flexDirection = .row
        view.addSubview(container)
        for i in 0..<4 {
            let item = ESVScrollView(frame: .init(x: 0, y: 0, width: 80, height: 500))
            item.justifyContent = .flexStart
            for _ in 0..<(i + 1) * 3 {
                let cell = ESVStackControl(frame: .init(x: 0, y: 0, width: 60, height: 60))
                item.addArrangedItem(cell)
                item.manageConfig(of: cell) { (config) in
                    config?.margin = .init(top: 10, left: 0, bottom: 0, right: 0)
                }
                cell.backgroundColor = UIColor.blue
                cell.flexDirection = .row
                cell.justifyContent = .spaceAround
                let left = UILabel(frame: .init(x: 0, y: 0, width: 10, height: 50))
                left.backgroundColor = UIColor.yellow
                cell.addArrangedItem(left)
                let right = UILabel(frame: .init(x: 0, y: 0, width: 30, height: 50))
                right.backgroundColor = UIColor.red
                cell.addArrangedItem(right)
            }
            item.backgroundColor = UIColor.green
            container.addArrangedItem(item)
        }
    }

}
