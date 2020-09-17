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
        backgroundColor = (index % 2) == 0 ? UIColor.red : UIColor.blue
    }
}

class Sample3ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let recycle = ESVRecycleView(frame: self.view.bounds)
        recycle.backgroundColor = UIColor.green
        recycle.registerGenerator({ () -> UIView & ESVRecycleCellType in
            return Display()
        }, forIdentifier: "display")
        recycle.flexDirection = .row
        recycle.alignItems = .center
//        recycle.justifyContent = .flexStart
        self.view.addSubview(recycle)
        recycle.addArrangedItems(models)
        models.forEach { (model) in
            recycle.manageConfig(of: model) { (config) in
                config?.margin = UIEdgeInsets(top: 150, left: 5, bottom: 5, right: 0)
            }
        }
    }
    
    let models : [ESVRecyclableModel] = {
        let result: [ESVRecyclableModel] = [
            ESVRecyclableModel(),
            ESVRecyclableModel(),
            ESVRecyclableModel(),
            ESVRecyclableModel(),
            ESVRecyclableModel(),
            ESVRecyclableModel(),
            ESVRecyclableModel(),
            ESVRecyclableModel(),
            ESVRecyclableModel(),
            ESVRecyclableModel(),
            ESVRecyclableModel(),
            ESVRecyclableModel(),
            ESVRecyclableModel(),
            ESVRecyclableModel(),
            ESVRecyclableModel(),
            ESVRecyclableModel(),
            ESVRecyclableModel(),
            ESVRecyclableModel(),
            ESVRecyclableModel(),
            ESVRecyclableModel(),
            ESVRecyclableModel(),
            ESVRecyclableModel(),
            ESVRecyclableModel(),
        ]
        result.forEach { (model) in
            model.frame = CGRect(x: 0, y: 0, width: 10 + Int(arc4random()) % 20, height: 120 + Int(arc4random()) % 240)
            model.identifier = "display"
        }
        return result
    }()

}
