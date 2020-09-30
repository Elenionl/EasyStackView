//
//  AppDelegate.swift
//  Demo
//
//  Created by Elenion on 2020/4/2.
//  Copyright © 2020 Elenion. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow()
        window.rootViewController = UINavigationController(rootViewController: Sample5ViewController())
        window.backgroundColor = UIColor.red
        self.window = window
        window.makeKeyAndVisible()
        return true
    }

}

