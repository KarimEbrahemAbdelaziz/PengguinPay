//
//  AppDelegate.swift
//  PenguinPay
//
//  Created by Karim Ebrahem on 03/08/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static var shared: AppDelegate {
        return (UIApplication.shared.delegate as? AppDelegate)!
    }
    private let compositeApp = AppDelegateFactory.default.make()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        _ = compositeApp.application?(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        compositeApp.applicationDidEnterBackground?(application)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        compositeApp.applicationWillEnterForeground?(application)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        compositeApp.applicationDidBecomeActive?(application)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        compositeApp.applicationWillTerminate?(application)
    }
}

