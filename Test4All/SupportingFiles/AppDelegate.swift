//
//  AppDelegate.swift
//  Test4All
//
//  Created by George Gomes on 06/07/19.
//  Copyright © 2019 George Gomes. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let provider = TaskProvider()
        provider.getList { (resutl) in
            switch resutl  {
                
            case .success(_):
                break
            case .failure(_):
                break
            }
        }
        return true
    }
}

