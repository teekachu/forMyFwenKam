//
//  AppDelegate.swift
//  Project 7
//
//  Created by Ting Becker on 6/17/20.
//  Copyright © 2020 TeeksCode. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        //gets called by IOS when the app has finished loading and is ready to be used
//        if let tabBarController = window?.rootViewController as? UITabBarController {
//
//            let storyboard = UIStoryboard(name: "main", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "NavController")
//            vc.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
//            tabBarController.viewControllers?.append(vc)
//        }
//        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

