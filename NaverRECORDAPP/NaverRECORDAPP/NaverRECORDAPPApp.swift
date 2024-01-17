//
//  NaverRECORDAPPApp.swift
//  NaverRECORDAPP
//
//  Created by 양시관 on 1/5/24.
//

import SwiftUI

@main // 앱이 시작한다는 시작점을 알려주는
struct NaverRECORDAPPApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    //@ 부터 Adaptor 까지 기존 uikit 에 있던 기능들을 swiftui 에서 사용할 수 있도록 해놓은것이구만
   // AppDelegate 클래스의 인스턴스를 appDelegate 라는 이름으로 만들어 SwiftUI 생명주기와 함께 동작하도록 하는거구만여
    var body: some Scene {
        WindowGroup {// 여기서 앱메인 뷰를 그리고
            OnboardingView() // 이게 어떤 뷰부터 시작할지를 정해주는거구만 ..
        }
        
    }
}
