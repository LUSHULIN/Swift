//
//  AppDelegate.swift
//  Swift_Tip
//
//  Created by Jason on 16/01/2018.
//  Copyright © 2018 陆林. All rights reserved.
//

import UIKit
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let _tableViewController:UITableViewController = TableViewController()
        
        let nav:UINavigationController = UINavigationController.init(rootViewController: _tableViewController)
        
        self.window?.rootViewController = nav
        
        var statusMessage:String?
        
     
        
        
//        let NetworkManager = NetworkReachabilityManager(host: "www.baidu.com")
//        NetworkManager!.listener = { status in
//            switch status {
//            case .notReachable:
//                self.checkNetwork(networkStatus: "网络不可见")
//            case .unknown:
//                self.checkNetwork(networkStatus: "未知网络")
//            case .reachable(NetworkReachabilityManager.ConnectionType.ethernetOrWiFi):
//                self.checkNetwork(networkStatus: "当前wifi网络")
//            case .reachable(NetworkReachabilityManager.ConnectionType.wwan):
//                self.checkNetwork(networkStatus: "手机蜂窝网络")
//                
//            }
//        }
//        NetworkManager!.startListening()
        
        self.window!.backgroundColor = UIColor.white
        self.window!.makeKeyAndVisible()
        return true
    }

    func checkNetwork(networkStatus status:String) {
        let alert = UIAlertController(title: "友情提示", message: "当前网络状态:\(status)", preferredStyle: UIAlertControllerStyle.alert)
        let actionOK = UIAlertAction.init(title: "ok", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(actionOK)
        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
        
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

