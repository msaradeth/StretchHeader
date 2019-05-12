//
//  AppDelegate.swift
//  StretchHeader
//
//  Created by Mike Saradeth on 5/9/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let names: [String?] = ["Mike Saradeth", "John Smith", nil, "David Brown", "Janet Jonshon"]
        let stretchHeader = StretchHeader(height: 150, maxHeight: 600)
        let vc = ListVC(items: names, stretchHeader: stretchHeader)
        vc.title = "List"
        
//        let rootNav = UINavigationController(rootViewController: vc)
//        rootNav.navigationBar.prefersLargeTitles = true
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = vc
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }


}

