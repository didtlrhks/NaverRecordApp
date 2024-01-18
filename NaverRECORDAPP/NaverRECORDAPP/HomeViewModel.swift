//
//  HomeViewModel.swift
//  NaverRECORDAPP
//
//  Created by 양시관 on 1/11/24.
//

import Foundation


class HomeViewModel: ObservableObject {//클래스가 구현되어있고 옵저버블옵젝트 프로토콜을 따르면서 homeview 에서 이클래스안에 데이터와 인스턴스를 사용할수있도록 이 프로토콜을 사용한거다 그래서 여기서 변한 친구들의 데이터들을 이프로토콜을 구독하는 녀석들한테 데이터를 업데이트해줄수있음
  @Published var selectedTab: Tab // 여기서일단 어떤 뷰에 있는 지알려줄려고 이넘타입의 클래스인 Tab 열거형의 타입을 따른다고 알려주고있고 퍼블리시드는 이변수가 변하게되면 해당 데이터를 업뎃해주겠다라는 모습이보임
  @Published var todosCount: Int
  @Published var memosCount: Int
  @Published var voiceRecordersCount: Int
  
  init(
    selectedTab: Tab = .voiceRecorder,
    todosCount: Int = 0,
    memosCount: Int = 0,
    voiceRecordersCount: Int = 0
  ) {
    self.selectedTab = selectedTab
    self.todosCount = todosCount
    self.memosCount = memosCount
    self.voiceRecordersCount = voiceRecordersCount
  }
}

extension HomeViewModel {
  func setTodosCount(_ count: Int) {
    todosCount = count
  }
  
  func setMemosCount(_ count: Int) {
    memosCount = count
  }
  
  func setVoiceRecordersCount(_ count: Int) {
    voiceRecordersCount = count
  }
  
  func changeSelectedTab(_ tab: Tab) {
    selectedTab = tab
  }
}
