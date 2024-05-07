//
//  AppDelegate.swift
//  lets_go
//
//  Created by Ishan Singla on 25/04/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private var authService: AuthService = AuthService()
    
    var window: UIWindow?
  

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
                do {
                    try authService.getCurrentUser()
                    print("User already logged in")
                    let storyboard = UIStoryboard(name: "AuthorisedApp", bundle: nil)
                    
                    window?.rootViewController = storyboard.instantiateInitialViewController()
                    window?.makeKeyAndVisible()
                    return true
                }
                catch{
                    print("User not logged in")
                    let storyboard = UIStoryboard(name: "AuthApp", bundle: nil)
                    
                    window?.rootViewController = storyboard.instantiateInitialViewController()
                    window?.makeKeyAndVisible()
                    return true
                }
    }
}

