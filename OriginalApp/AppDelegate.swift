//
//  AppDelegate.swift
//  OriginalApp
//
//  Created by 金井菜津希 on 2023/06/21.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Realmの設定オブジェクトを取得
        let config = Realm.Configuration(
            schemaVersion: 3, // スキーマバージョンを指定
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 2 {
                    // スキーマバージョンが1以下の場合に実行されるマイグレーション処理を記述
                    // 例: migration.enumerateObjects(ofType: YourObject.className()) { oldObject, newObject in
                    //       // マイグレーション処理のコードを記述
                    //     }
                }
                // 他のバージョンのマイグレーション処理をここに追加
            })

        // マイグレーション処理を実行
        do {
            let realm = try Realm(configuration: config)
            print("Realmのスキーマバージョン: \(realm.configuration.schemaVersion)")
        } catch {
            print("Realmマイグレーションエラー: \(error)")
        }

        return true
    }
}

    
    
    
        
        
        
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            // Override point for customization after application launch.
            
            let config = Realm.Configuration(schemaVersion: 1)
            Realm.Configuration.defaultConfiguration = config
            
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
        
        
    
    

