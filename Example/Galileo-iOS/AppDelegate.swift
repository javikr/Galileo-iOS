//
//  AppDelegate.swift
//  Galileo
//
//  Created by Javier Aznar de los Rios on 08/11/2018.
//  Copyright © 2018 The Clash Soft. All rights reserved.
//

import UIKit

#if DEBUG
import Galileo_iOS
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        let rootView = RootViewController()
        
        #if DEBUG
        print("DEBUG!")
        let samplePlugin1 = SamplePluginViewController()
        let samplePlugin2 = SamplePluginViewController()
        let samplePlugin3 = SamplePluginViewController()
        let samplePlugin4 = SamplePluginViewController()
        let samplePlugin5 = SamplePluginViewController()
        let samplePlugin6 = SamplePluginViewController()
        let samplePlugin7 = SamplePluginViewController()
        
        window = Galileo(frame: UIScreen.main.bounds, customPlugins: [samplePlugin1, samplePlugin2, samplePlugin3, samplePlugin4, samplePlugin5, samplePlugin6, samplePlugin7])
        #else
        print("NO DEBUG!")
        window = UIWindow(frame: UIScreen.main.bounds)
        #endif
        
        window?.rootViewController = rootView
        window?.makeKeyAndVisible()
        
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

