//
//  AppDelegate.swift
//  NaverRECORDAPP
//
//  Created by 양시관 on 1/11/24.
//

import Foundation
import UIKit

class AppDelegate : NSObject, UIApplicationDelegate {
    var notificationDelegate = NotificationDelegate()
    
    func application(
        _ applocation: UIApplication,
        didFinishLaunchingWithOptikons launchOptions : [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        UNUserNotificationCenter.current().delegate = notificationDelegate
        return true
        
    }
}
