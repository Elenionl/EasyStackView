//
//  Sample3ViewController.swift
//  Demo
//
//  Created by Elenion on 2020/8/2.
//  Copyright © 2020 Elenion. All rights reserved.
//

import UIKit
import EasyStackView

class Display: UIView, ESVRecycleCellType {
    var model: ESVRecyclableModel?
    
    func prepareForReuse() {
        model = nil
    }
    
    func config(with model: ESVRecyclableModelType, index: UInt) {
        self.model = model as? ESVRecyclableModel
        backgroundColor = (index % 2) == 0 ? UIColor.white : UIColor.black
    }
}

class Sample3ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let recycle = ESVRecycleView(frame: self.view.bounds)
        recycle.backgroundColor = UIColor.lightGray
        recycle.registerGenerator({ () -> UIView & ESVRecycleCellType in
            return Display()
        }, forIdentifier: "display")
        recycle.flexDirection = .column
        recycle.alignItems = .center
//        recycle.justifyContent = .flexStart
        self.view.addSubview(recycle)
        recycle.addArrangedItems(models)
        models.forEach { (model) in
            recycle.manageConfig(of: model) { (config) in
                config?.margin = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
            }
        }
    }
    
    let models : [ESVRecyclableModel] = {
        var result: [ESVRecyclableModel] = []
        for _ in 0..<1000 {
            let model = ESVRecyclableModel()
            model.frame = CGRect(x: 0, y: 0, width: 50 + Int(arc4random()) % 240, height: 20 + Int(arc4random()) % 40)
            model.identifier = "display"
            result.append(model)
        }
        return result
    }()

}
