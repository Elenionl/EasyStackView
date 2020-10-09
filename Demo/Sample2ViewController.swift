//
//  Sample2ViewController.swift
//  Demo
//
//  Created by Elenion on 2020/7/20.
//  Copyright © 2020 Elenion. All rights reserved.
//

import UIKit
import EasyStackView

class Sample2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let container = ESVScrollView(frame: self.view.bounds)
        container.alignItems = .stretch
        container.padding = .init(top: 15, left: 15, bottom: 15, right: 15)
        container.spaceBetween = 10
        view.addSubview(container)
        for _ in 0..<30 {
            let cell = createCell()
            cell.layer.cornerRadius = 5
            cell.clipsToBounds = true
            container.addArrangedItem(cell)
        }
    }
    
    func createCell() -> UIView {
        let item = ESVStackView(frame: .init(x: 0, y: 0, width: 200, height: 60))
        item.flexDirection = .row
        item.alignItems = .center
        item.justifyContent = .flexStart
        item.backgroundColor = UIColor.lightGray
        let image = UIImageView(frame: .init(x: 0, y: 0, width: 50, height: 50))
        image.backgroundColor = UIColor.white
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        item.addArrangedItem(image)
        item.manageConfig(of: image) { (config) in
            config?.margin = .init(top: 5, left: 5, bottom: 5, right: 5)
        }
        let container = ESVStackPlaceHolder(frame: .init(x: 0, y: 0, width: 150, height: 50))
        container.flexDirection = .column
        container.alignItems = .stretch
        container.justifyContent = .spaceBetween
        item.addArrangedItem(container)
        item.manageConfig(of: container) { (config) in
            config?.growth = true
            config?.shrink = true
            config?.margin = .init(top: 5, left: 5, bottom: 5, right: 5)
        }
        item.alignItems = .stretch
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 25))
        titleLabel.backgroundColor = UIColor.white
        titleLabel.text = "123"
        titleLabel.textColor = UIColor.darkGray
        container.addArrangedItem(titleLabel)
        let subTitleContainer = ESVStackPlaceHolder(frame: .init(x: 0, y: 0, width: 150, height: 20))
        container.addArrangedItem(subTitleContainer)
        subTitleContainer.justifyContent = .flexStart
        subTitleContainer.flexDirection = .row
        let tagIcon = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        tagIcon.backgroundColor = UIColor.white
        subTitleContainer.addArrangedItem(tagIcon)
        let empty = ESVStackPlaceHolder(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        subTitleContainer.addArrangedItem(empty)
        subTitleContainer.manageConfig(of: empty) { (config) in
            config?.growth = true
            config?.shrink = true
        }
        let rightLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 45, height: 20))
        rightLabel.backgroundColor = UIColor.white
        subTitleContainer.addArrangedItem(rightLabel)
        return item
    }

}
