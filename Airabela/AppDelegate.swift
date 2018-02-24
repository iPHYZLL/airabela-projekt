//
//  AppDelegate.swift
//  Airabela
//
//  Created by Alen Kirm on 12. 02. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.sharedManager().enable = true
    
        window = UIWindow()
        
        let mainNavigationViewController = UINavigationController(rootViewController: HomeController())
        
        mainNavigationViewController.navigationBar.isTranslucent = false
        mainNavigationViewController.navigationBar.barTintColor = UIColor.airabelaBlue
        mainNavigationViewController.navigationBar.tintColor = UIColor.airabelaGray
        
        
        window?.rootViewController = mainNavigationViewController
        window?.makeKeyAndVisible()
        
        if #available(iOS 11.0, *) {
            mainNavigationViewController.navigationBar.prefersLargeTitles = true
            UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.airabelaGray]
        } else {
            mainNavigationViewController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.airabelaGray]

        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

