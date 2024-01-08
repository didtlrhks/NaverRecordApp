//
//  MemoViewModel.swift
//  NaverRECORDAPP
//
//  Created by 양시관 on 1/8/24.
//

import Foundation


class MemoViewModel : ObservableObject {
    @Published var memo : Memo
    
    init(memo: Memo) {
        self.memo = memo
    }
}
