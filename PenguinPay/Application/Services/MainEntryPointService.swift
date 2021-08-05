//
//  MainEntryPointService.swift
//  PenguinPay
//
//  Created by Karim Ebrahem on 05/08/2021.
//

import Foundation
import UIKit

class MainEntryPointService: ApplicationService {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        AppDelegate.shared.window = UIWindow(frame: UIScreen.main.bounds)

        let sendMoneySceneConfigurator = SendMoneySceneConfigurator()
        let initialViewController = sendMoneySceneConfigurator.configure()

        AppDelegate.shared.window?.rootViewController = initialViewController
        AppDelegate.shared.window?.makeKeyAndVisible()

        return true
    }
}
