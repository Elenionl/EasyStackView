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
        container.backgroundColor = UIColor.lightGray
        container.justifyContent = .spaceAround
        container.flexDirection = .row
        view.addSubview(container)
        for i in 0..<4 {
            let item = ESVScrollView(frame: .init(x: 0, y: 0, width: 80, height: 500))
            item.backgroundColor = UIColor.white
            item.layer.cornerRadius = 5
            item.justifyContent = .flexStart
            for _ in 0..<(i + 1) * 4 {
                let cell = ESVStackControl(frame: .init(x: 0, y: 0, width: 60, height: 60))
                item.addArrangedItem(cell)
                item.manageConfig(of: cell) { (config) in
                    config?.margin = .init(top: 30, left: 0, bottom: 0, right: 0)
                }
                cell.backgroundColor = UIColor.white
                cell.layer.cornerRadius = 5
                cell.layer.shadowColor = UIColor.black.cgColor
                cell.layer.shadowOpacity = 0.2
                cell.layer.shadowRadius = 8
                cell.layer.shadowOffset = CGSize.zero
                cell.flexDirection = .row
                cell.justifyContent = .spaceAround
                let left = UILabel(frame: .init(x: 0, y: 0, width: 10, height: 50))
                left.backgroundColor = UIColor.lightGray
                cell.addArrangedItem(left)
                let right = UILabel(frame: .init(x: 0, y: 0, width: 30, height: 50))
                right.backgroundColor = UIColor.lightGray
                cell.addArrangedItem(right)
            }
            container.addArrangedItem(item)
        }
    }

}
