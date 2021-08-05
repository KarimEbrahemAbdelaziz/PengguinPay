//
//  CompositeAppDelegate.swift
//  PenguinPay
//
//  Created by Karim Ebrahem on 03/08/2021.
//

import Foundation
import UIKit

class CompositeAppDelegate: ApplicationService {
    private let applicationServices: [ApplicationService]

    init(applicationServices: [ApplicationService]) {
        self.applicationServices = applicationServices
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        applicationServices.forEach { _ = $0.application?(application, didFinishLaunchingWithOptions: launchOptions) }
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        applicationServices.forEach { _ = $0.applicationDidEnterBackground?(application) }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        applicationServices.forEach { _ = $0.applicationWillEnterForeground?(application) }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        applicationServices.forEach { _ = $0.applicationDidBecomeActive?(application) }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        applicationServices.forEach { _ = $0.applicationWillTerminate?(application) }
    }
}
