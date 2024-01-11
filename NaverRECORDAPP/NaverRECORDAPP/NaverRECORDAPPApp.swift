//
//  NaverRECORDAPPApp.swift
//  NaverRECORDAPP
//
//  Created by 양시관 on 1/5/24.
//

import SwiftUI

@main
struct NaverRECORDAPPApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            OnboardingView()
        }
    }
}
