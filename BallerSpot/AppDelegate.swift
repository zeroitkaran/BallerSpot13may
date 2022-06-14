//
//  AppDelegate.swift
//  BallerSpot
//
//  Created by Zero ITSolutions on 22/01/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.

import UIKit
import Firebase
import UserNotifications
import FirebaseInstanceID
import FirebaseMessaging
import UserNotificationsUI
import IQKeyboardManagerSwift
import FirebaseCrashlytics  

let appDelegate = UIApplication.shared.delegate as! AppDelegate

@UIApplicationMain
 class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        if (launchOptions != nil)
        {
             //opened from a push notification when the app is closed
            let navigationController = application.windows[0].rootViewController as! UINavigationController
               let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let yourVC = storyboard.instantiateViewController(withIdentifier: "NotificationViewController")
            navigationController.pushViewController(yourVC, animated: true)
            

        }
        // Override point for customization after application launch.
         IQKeyboardManager.shared.enable = true
        if #available(iOS 10.0, *) {
             // For iOS 10 display notification (sent via APNS)
             UNUserNotificationCenter.current().delegate = self

             let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
             UNUserNotificationCenter.current().requestAuthorization(
               options: authOptions,
               completionHandler: {_, _ in })
           } else {
             let settings: UIUserNotificationSettings =
             UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
             application.registerUserNotificationSettings(settings)
           }
           application.registerForRemoteNotifications()
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
// Push Notificaion
extension AppDelegate {
func registerForPushNotifications() {
    if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            [weak self] (granted, error) in
            print("Permission granted: \(granted)")

            guard granted else {
                print("Please enable \"Notifications\" from App Settings.")
                self?.showPermissionAlert()
                return
            }
            self?.getNotificationSettings()
        }
    } else {
        let settings = UIUserNotificationSettings(types: [.alert, .sound, .badge], categories: nil)
        UIApplication.shared.registerUserNotificationSettings(settings)
        UIApplication.shared.registerForRemoteNotifications()
    }
}
@available(iOS 10.0, *)
func getNotificationSettings() {

    UNUserNotificationCenter.current().getNotificationSettings { (settings) in
        print("Notification settings: \(settings)")
        guard settings.authorizationStatus == .authorized else { return }
        DispatchQueue.main.async {
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
}

func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    let tokenParts = deviceToken.map { data -> String in
        return String(format: "%02.2hhx", data)
    }
    let token = tokenParts.joined()
    print("Device Token: \(token)")
    //UserDefaults.standard.set(token, forKey: DEVICE_TOKEN)
}

func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    print("Failed to register: \(error)")
}

func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {

    // If your app was running and in the foreground
    // Or
    // If your app was running or suspended in the background and the user brings it to the foreground by tapping the push notification

    print("didReceiveRemoteNotification /(userInfo)")

    guard let dict = userInfo["aps"]  as? [String: Any], let msg = dict ["alert"] as? String else {
        print("Notification Parsing Error")
        if application.applicationState == .inactive || application.applicationState == .background {
             let obj : NotificationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        // //        let objRoot : SWRevealViewController = SWRevealViewController(rearViewController: objRear, frontViewController: objHomeVC)
                 let objNavi : UINavigationController = UINavigationController(rootViewController: obj)
                objNavi.setNavigationBarHidden(true, animated: true)
                appDelegate.window?.rootViewController = objNavi
                appDelegate.window?.makeKeyAndVisible()
        }
        return

    }
}
    
    // This method is called when user clicked on the notification
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void)
//    {
//        // Do whatever you want when the user tapped on a notification
//        // If you are waiting for specific data from the notification
//        // (e.g., key: "target" and associated with "value"),
//        // you can capture it as follows then do the navigation:
//
//        // You may print `userInfo` dictionary, to see all data received with the notification.
////        let userInfo = response.notification.request.content.userInfo
////        if let targetValue = userInfo["target"] as? String, targetValue == "value"
////        {
//            coordinateToSomeVC()
//     //   }
//
//        completionHandler()
//    }
//
//    private func coordinateToSomeVC()
//    {
//        guard let window = UIApplication.shared.keyWindow else { return }
//
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let yourVC = storyboard.instantiateViewController(withIdentifier: "startVC")
//
//        let navController = UINavigationController(rootViewController: yourVC)
//        navController.modalPresentationStyle = .fullScreen
//        let VC = storyboard.instantiateViewController(withIdentifier: "NotificationViewController")
//        navController.pushViewController(VC, animated: true)
//        // you can assign your vc directly or push it in navigation stack as follows:
//        window.rootViewController = navController
//
//        window.makeKeyAndVisible()
//    }

//func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//
//    // retrieve the root view controller (which is a tab bar controller)
//    guard let rootViewController = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController else {
//        return
//    }
//
//    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//    // instantiate the view controller we want to show from storyboard
//    // root view controller is tab bar controller
//    // the selected tab is a navigation controller
//    // then we push the new view controller to it
//    if  let conversationVC = storyboard.instantiateViewController(withIdentifier: "NotificationViewController") as? NotificationViewController,
//        let tabBarController = rootViewController as? UITabBarController,
//        let navController = tabBarController.selectedViewController as? UINavigationController {
//
//            // we can modify variable of the new view controller using notification data
//            // (eg: title of notification)
//         //   conversationVC.senderDisplayName = response.notification.request.content.title
//            // you can access custom data of the push notification by using userInfo property
//            // response.notification.request.content.userInfo
//            navController.pushViewController(conversationVC, animated: true)
//    }
//
//    // tell the app that we have finished processing the user’s action / response
//    completionHandler()
//}
    
    
    
func showPermissionAlert() {
    let alert = UIAlertController(title: "WARNING", message: "Please enable access to Notifications in the Settings app.", preferredStyle: .alert)

    let settingsAction = UIAlertAction(title: "Settings", style: .default) {[weak self] (alertAction) in
        self?.gotoAppSettings()
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)

    alert.addAction(settingsAction)
    alert.addAction(cancelAction)

    DispatchQueue.main.async {
        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}

private func gotoAppSettings() {

    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
        return
    }
    if UIApplication.shared.canOpenURL(settingsUrl) {
        UIApplication.shared.openURL(settingsUrl)
    }
}
}
