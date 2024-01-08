//
//  TodoViewModel.swift
//  NaverRECORDAPP
//
//  Created by 양시관 on 1/8/24.
//

import Foundation

class TodoViewModel : ObservableObject {
    @Published var title : String
    @Published var time : Date
    @Published var isDisplayCalendar : Bool
    @Published var day : Date
    
    init(title: String = "",
         time: Date = Date(),
         isDisplayCalendar: Bool = false,
         day : Date = Date()
    )
    {
        self.title = title
        self.time = time
        self.isDisplayCalendar = isDisplayCalendar
        self.day = day
        
    }
}

extension TodoViewModel {
    func setIsDisplayCalendar(
        _ isDispaly : Bool
    ){
        isDisplayCalendar = isDispaly
    }
}
