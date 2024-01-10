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
    
     init(isDisplaySetTimeView: Bool = true,
          time: Time = .init(hours: 0, minutes: 0, seconds: 0),
          timer: Timer? = nil,
          timeRemaining: Int = 0,
          isPaused: Bool = false
     )
    {
        self.isDisplaySetTimeView = isDisplaySetTimeView
        self.time = time
        self.timer = timer
        self.timeRemaining = timeRemaining
        self.isPaused = isPaused
    }
    
    
}

extension TimerViewModel {
    func settingBtnTapped() {
        isDisplaySetTimeView = false
        timeRemaining = time.convertedSeconds
        // TODO: - 타이머 시작 메서드 호출
        startTimer()
    }
    
    func cacelBtnTapped() {
        //TODO: - 타이머 종료 메서드 호출
        stopTimer()
        isDisplaySetTimeView = true
    }
    
    func pauseOrRestartBtnTapped() {
        if isPaused {
            //TODO: - 타이머 시작 메서드 호출
            startTimer()
        }
        else {
            timer?.invalidate()
            timer = nil
        }
        isPaused.toggle()
    }
}

private extension TimerViewModel {
    func startTimer() {
        guard timer == nil else{ return }
        
        timer = Timer.scheduledTimer(
            withTimeInterval : 1,
            repeats: true
        ) {
            _ in
            if self.timeRemaining > 0{
                self.timeRemaining -= 1
            }else {
                self.stopTimer()
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
