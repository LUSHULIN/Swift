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

    struct Define {
       static let kUserHasOnboardedKey = "user_has_onboarded"
    }
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        
        let falg = UserDefaults.standard.bool(forKey: Define.kUserHasOnboardedKey)
        if falg {
           projectMain()
        } else {
           setupGuide()
        }
        
        self.window!.backgroundColor = UIColor.white
        self.window!.makeKeyAndVisible()
        return true
    }

    func setupGuide(){
    
        let firstPage = OnboardingContentViewController(title: "What A Beautiful Photo", body: "This city background image is so beautiful.", image: UIImage(named: "blue"), buttonText: "Text For Button") { () -> Void in
           
        }
        
        let secondPage = OnboardingContentViewController(title: "I'm so sorry", body: "I can't get over the nice blurry background photo.", image: UIImage(named: "red"), buttonText: "Text For Button") { () -> Void in
           
        }
        
        let thirdPage = OnboardingContentViewController(title: "welcome you !", body: "Enjoy your app", image: UIImage(named: "yellow"), buttonText: "Get Started") { () -> Void in
            self.projectMain()
        }
        
        let onboardingVC = OnboardingViewController(backgroundImage: UIImage(named: "background"), contents: [firstPage, secondPage, thirdPage])
        self.window?.rootViewController = onboardingVC
        
    }
    func projectMain() {
        UserDefaults.standard.set(false, forKey: Define.kUserHasOnboardedKey)
        
        let _tableViewController = RootTableViewController()
        let nav:UINavigationController = UINavigationController.init(rootViewController: _tableViewController)
        self.window?.rootViewController = nav
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

