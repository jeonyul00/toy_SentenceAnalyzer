//
//  AppDelegate.swift
//  SentenceAnalyzer
//
//  Created by 전율 on 11/6/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        DispatchQueue.global().async {
            guard !FileManager.default.fileExists(atPath: URL.tempFileURL.path) else { return }
            if let str = try? String(contentsOf: URL.dataURL) {
                let source = (1...2000).reduce("", {s, _ in s + str})
                
                do {
                    try source.write(to: URL.tempFileURL, atomically: true, encoding: .utf8)
                    let attr = try FileManager.default.attributesOfItem(atPath: URL.tempFileURL.path)
                    if let size = attr[.size] as? UInt64 {
                        print("size is ::: \(size.formatted(.byteCount(style: .file)))")
                    }
                } catch {
                    print(error)
                }
            }
        }
        
        
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

