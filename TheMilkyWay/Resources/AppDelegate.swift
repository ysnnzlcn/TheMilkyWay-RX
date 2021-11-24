//
//  AppDelegate.swift
//  TheMilkyWay
//
//  Created by Yasin Nazlican on 17.11.2021.
//

import UIKit
import Core

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    public var window: UIWindow?
    public private(set) var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setup()
        return true
    }

    private func setup() {
        let window = UIWindow()
        appCoordinator = AppCoordinator(window: window, service: RestNASAServices())
        /// Configure app by selecting REST or MOCK services.
        self.window = window
        appCoordinator.start()
    }
}
