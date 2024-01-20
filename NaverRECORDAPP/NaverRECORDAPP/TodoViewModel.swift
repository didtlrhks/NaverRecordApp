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
    // ui의 상태를 최신화해주는 published를 사용해준다.
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
        isDisplayCalendar = isDispaly // isDisplay의 값을 받아서 isDisplayCalendar 속성에 할당할거임 이제 이런게 동작을 캡슐화했다고 봐도 맞는거지
    }
}
