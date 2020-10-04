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
        view.addSubview(scrollView)
        scrollView.frame = view.bounds
        let button1 = Button(frame: .init(x: 0, y: 0, width: 200, height: 100))
        button1.updateConfig(name: "Sample1") { [weak self] in
            self?.navigationController?.pushViewController(Sample1ViewController(), animated: true)
        }
        scrollView.addArrangedItem(button1)
        let button2 = Button(frame: .init(x: 0, y: 0, width: 200, height: 100))
        button2.updateConfig(name: "Sample2") { [weak self] in
            self?.navigationController?.pushViewController(Sample2ViewController(), animated: true)
        }
        scrollView.addArrangedItem(button2)
        let button3 = Button(frame: .init(x: 0, y: 0, width: 200, height: 100))
        button3.updateConfig(name: "Sample3") { [weak self] in
            self?.navigationController?.pushViewController(Sample3ViewController(), animated: true)
        }
        scrollView.addArrangedItem(button3)
        let button4 = Button(frame: .init(x: 0, y: 0, width: 200, height: 100))
        button4.updateConfig(name: "Sample4") { [weak self] in
            self?.navigationController?.pushViewController(Sample4ViewController(), animated: true)
        }
        scrollView.addArrangedItem(button4)
        let button5 = Button(frame: .init(x: 0, y: 0, width: 200, height: 100))
        button5.updateConfig(name: "Sample5") { [weak self] in
            self?.navigationController?.pushViewController(Sample5ViewController(), animated: true)
        }
        scrollView.addArrangedItem(button5)
    }
    
    lazy var scrollView: ESVScrollView = {
        let item = ESVScrollView()
        item.flexDirection = .column
        item.alignItems = .stretch
        item.justifyContent = .flexStart
        return item
    }()
}

class Button: ESVStackControl {
    lazy var label: UILabel = {
        let item = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        item.textColor = UIColor.black
        item.textAlignment = .center
        return item
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addArrangedItem(label)
        addTarget(self, action: #selector(didTapItem), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateConfig(name: String, action: @escaping () -> Void) {
        label.text = name
        self.action = action
    }
    
    var action: (() -> Void)?
    
    @objc func didTapItem() {
        action?()
    }
}

