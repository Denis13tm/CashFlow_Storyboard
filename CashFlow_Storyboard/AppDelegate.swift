//
//  AppDelegate.swift
//  CashFlow_Storyboard
//
//  Created by Otabek Tuychiev
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UNUserNotificationCenter.current().delegate = self
        
        // Initialize Core Data stack
        setupCoreDataStack()
        initUISetups()
        return true
    }
    
    private func initUISetups() {
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        UINavigationBar.appearance().tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        UINavigationBar.appearance().titleTextAttributes =  [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.3058553934, green: 0.8274359107, blue: 0.9806613326, alpha: 1)]
        UINavigationBar.appearance().shadowImage = UIImage()
        
//        UINavigationBar.appearance().isTranslucent = false
//        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
            let container = NSPersistentContainer(name: "MainCoreDB") // Replace "YourModelName" with your actual model name
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()

        func saveContext () {
            let context = persistentContainer.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }

        // MARK: - Core Data Saving support

        func setupCoreDataStack() {
            let _ = persistentContainer // This line initializes the Core Data stack
        }

    // MARK: - UISceneSession Lifecycle

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

