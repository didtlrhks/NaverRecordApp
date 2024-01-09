//
//  Double+Extensions.swift
//  NaverRECORDAPP
//
//  Created by 양시관 on 1/9/24.
//

import Foundation

extension Double {
    var formattedTimeInterval : String {
        let totalSeconds = Int(self)
        let seconds = totalSeconds % 60
        let minutes = (totalSeconds / 60) % 60
        
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
