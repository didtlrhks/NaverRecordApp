//
//  Memo.swift
//  NaverRECORDAPP
//
//  Created by 양시관 on 1/8/24.
//

import Foundation


struct Memo : Hashable {
    
    var title : String
    var content : String
    var date : Date
    var id = UUID()
    
    var convertedDate : String{
        String("\(date.formattedDay) - \(date.formattedTime)")
    }
}
