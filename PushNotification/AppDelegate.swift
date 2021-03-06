//
//  AppDelegate.swift
//  PushNotification
//
//  Created by nvovap on 5/16/16.
//  Copyright © 2016 nvovap. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        
//        let replyAction = UIMutableUserNotificationAction()
//        replyAction.title = "Reply"
//        replyAction.identifier = "comment-reply"
//        replyAction.activationMode = .Background
//        replyAction.authenticationRequired = false
//        replyAction.behavior = .TextInput
//        
//        
//        let category = UIMutableUserNotificationCategory()
//        category.identifier = "reply"
//        category.setActions([replyAction], forContext: UIUserNotificationActionContext.Default)
//        
//        let settings = UIUserNotificationSettings(forTypes: [.Sound, .Alert], categories: [category])
//        
//        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
//        
//        UIApplication.sharedApplication().registerForRemoteNotifications()
        
        return true
    }
    
    
    //Handler Remote Notifications
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        print(deviceToken);
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("Error in registration. Error: \(error)")
    }
    
    
    //    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [NSObject : AnyObject], completionHandler: () -> Void) {
    //
    //        if identifier == "comment-reply" {
    //            let response = userInfo
    //        }
    //
    //    }
    
    
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [NSObject : AnyObject], withResponseInfo responseInfo: [NSObject : AnyObject], completionHandler: () -> Void) {
        if identifier == "comment-reply",
            let response = responseInfo[UIUserNotificationActionResponseTypedTextKey],
            responseText = response as? String {
            print(responseText)
        }
        
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

