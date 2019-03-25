//
//  AppDelegate.swift
//  SBT-Lesson-11 Homework-UICollectionView
//
//  Created by Dmitry Shapkin on 25/03/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .red
        let vc = ViewController()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        return true
    }
}
