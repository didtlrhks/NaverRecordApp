//
//  Timer.swift
//  NaverRECORDAPP
//
//  Created by 양시관 on 1/9/24.
//

import SwiftUI

struct Time {
    var hours : Int
    var minutes : Int
    var seconds : Int
    
    var convertedSeconds : Int {
        return (hours * 3600) + (minutes * 60) + seconds
        
    }
    
    static func fromSeconds(_ seconds : Int) -> Time {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let remainingSeconds = (seconds % 3600) % 60
        return Time(hours: hours, minutes: seconds, seconds: remainingSeconds)
    }
}
