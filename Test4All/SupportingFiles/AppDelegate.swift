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
        
        let taskProvider = TaskProvider()
        
        taskProvider.getImageData(withLink: "http://dev.4all.com:3003/usuario1.jpeg") { (result) in
            switch result {
                
            case .success(let data):
                print(data)
                break
            case .failure(_):
                break
            }
        }
        
        
        
        return true
    }
}

