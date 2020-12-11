//
//  Sample4ViewController.swift
//  Demo
//
//  Created by Elenion on 2020/9/18.
//  Copyright © 2020 Elenion. All rights reserved.
//

import UIKit
import EasyStackView

class Sample4ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let item = createAlert()
        view.addSubview(item)
        item.center = view.center
    }
    
    func createAlert() -> UIView {
        let container: ESVStackView = createContainer()
        container.flexDirection = .column
        container.alignItems = .stretch
        let title: UILabel = createTitle()
        container.addArrangedItem(title)
        let content: UITextView = createContent()
        container.addArrangedItem(content)
        container.manageConfig(of: content) { (config) in
            config?.margin = .init(top: 0, left: 10, bottom: 10, right: 10)
            config?.growth = true
        }
        let iconHolder: ESVScrollView = createIconHolder()
        iconHolder.showsHorizontalScrollIndicator = false
        container.addArrangedItem(iconHolder)
        iconHolder.flexDirection = .row
        iconHolder.padding = .init(top: 5, left: 5, bottom: 5, right: 5)
        iconHolder.spaceBetween = 5
        container.manageConfig(of: iconHolder) { (config) in
            config?.margin = .init(top: 10, left: 10, bottom: 10, right: 10)
        }
        for i in 0...4 {
            let icon: UIView = createIcon()
            if i % 3 == 0 {
                icon.backgroundColor = UIColor.red
            } else {
                icon.backgroundColor = UIColor.white
            }
            iconHolder.addArrangedItem(icon)
        }
        let recycleIconHolder: ESVRecycleView = createRecycleIconHolder()
        recycleIconHolder.showsHorizontalScrollIndicator = false
        container.addArrangedItem(recycleIconHolder)
        recycleIconHolder.flexDirection = .row
        container.manageConfig(of: recycleIconHolder) { (config) in
            config?.margin = .init(top: 10, left: 10, bottom: 10, right: 10)
        }
        recycleIconHolder.registerGenerator({ () -> UIView & ESVRecycleCellType in
            return RecycleIcon()
        }, forIdentifier: "RecycleIcon")
        recycleIconHolder.padding = .init(top: 5, left: 5, bottom: 5, right: 5)
        recycleIconHolder.spaceBetween = 5
        for _ in 0...10 {
            let model: ESVRecyclableModelType = ESVRecyclableModel<NSDictionary>()
            model.frame = .init(x: 0, y: 0, width: 50, height: 50)
            model.identifier = "RecycleIcon"
            recycleIconHolder.addArrangedItem(model)
        }
        let buttonContainer: ESVStackPlaceHolder = createButtonContainer()
        container.addArrangedItem(buttonContainer)
        buttonContainer.flexDirection = .row
        buttonContainer.alignItems = .stretch
        buttonContainer.padding = .init(top: 5, left: 5, bottom: 5, right: 5)
        buttonContainer.spaceBetween = 5
        let confirmButton = createConfirmButton()
        buttonContainer.addArrangedItem(confirmButton)
        buttonContainer.manageConfig(of: confirmButton) { (config) in
            config?.growth = true
        }
        let cancelButton = createCancelButton()
        buttonContainer.addArrangedItem(cancelButton)
        buttonContainer.manageConfig(of: cancelButton) { (config) in
            config?.growth = true
        }
        return container
    }
    
    func createContainer() -> ESVStackView {
        let container = ESVStackView(frame: CGRect(x: 0, y: 0, width: 200, height: 300))
        container.backgroundColor = UIColor.white
        container.layer.cornerRadius = 10
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowRadius = 40
        container.layer.shadowOpacity = 0.1
        container.layer.shadowOffset = CGSize(width: 5, height: 5)
        return container
    }
    
    func createTitle() -> UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
        label.textAlignment = .center
        label.textColor = UIColor.darkGray
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "Title"
        return label
    }
    
    func createContent() -> UITextView {
        let textView = UITextView(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        textView.isEditable = false;
        textView.backgroundColor = UIColor.clear
        textView.textColor = .lightGray
        textView.textAlignment = .center
        textView.font = .systemFont(ofSize: 12)
        textView.text = "This is content of all stuff. Good to see you today."
        return textView
    }
    
    func createIconHolder() -> ESVScrollView {
        let view = ESVScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor.lightGray
        return view
    }
    
    func createIcon() -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        view.layer.cornerRadius = 6
        return view
    }
    
    func createRecycleIconHolder() -> ESVRecycleView {
        let view = ESVRecycleView(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor.lightGray
        return view
    }
    
    class RecycleIcon: UIView, ESVRecycleCellType {
        func prepareForReuse() {
            
        }
        
        func config(with model: ESVRecyclableModelType, index: UInt) {
            self.layer.cornerRadius = 6
            self.backgroundColor = index % 3 == 0 ? UIColor.white : UIColor.red
        }
    }
    
    func createButtonContainer() -> ESVStackPlaceHolder {
        let placeholder = ESVStackPlaceHolder(frame: .init(x: 0, y: 0, width: 50, height: 50))
        return placeholder
    }
    
    func createConfirmButton() -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        button.setTitle("Confirm", for: UIControl.State.normal)
        button.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
        button.layer.cornerRadius = 6
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 40
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.backgroundColor = UIColor.white
        return button
    }
    
    func createCancelButton() -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        button.backgroundColor = UIColor.white
        button.setTitle("Cancel", for: UIControl.State.normal)
        button.setTitleColor(UIColor.red, for: UIControl.State.normal)
        button.layer.cornerRadius = 6
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 40
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.backgroundColor = UIColor.white
        return button
    }
}
