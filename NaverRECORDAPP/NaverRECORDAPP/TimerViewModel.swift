//
//  TimerViewModel.swift
//  NaverRECORDAPP
//
//  Created by 양시관 on 1/10/24.
//

import Foundation

class TimerViewModel : ObservableObject {
    @Published var isDisplaySetTimeView : Bool
    @Published var time : Time
    @Published var timer : Timer?
    @Published var timeRemaining : Int
    @Published var isPaused : Bool
    
     init(isDisplaySetTimeView: Bool,
          time: Time,
          timer: Timer? = nil,
          timeRemaining: Int,
          isPaused: Bool)
    {
        self.isDisplaySetTimeView = isDisplaySetTimeView
        self.time = time
        self.timer = timer
        self.timeRemaining = timeRemaining
        self.isPaused = isPaused
    }
}
