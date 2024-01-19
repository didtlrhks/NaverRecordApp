//
//  NavigationBtnType.swift
//  NaverRECORDAPP
//
//  Created by 양시관 on 1/7/24.
//

import Foundation


enum NavigationBtnType : String {
    case close
    case edit = "편집"
    case complete = "완료"
    case create = "생성"
}
    // 여기에서 rightbutton 에 대한 내용을 정의해서 customnavigation 에서 사용해줄수있음 즉 이 enum 타입의 값들을 반환해줌
