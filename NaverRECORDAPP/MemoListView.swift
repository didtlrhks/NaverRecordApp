//
//  MemoListView.swift
//  NaverRECORDAPP
//
//  Created by 양시관 on 1/8/24.
//

import SwiftUI

struct MemoListView: View {
    
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var memoListViewModel : MemoListViewModel
    
    var body: some View {
        
        ZStack{
            VStack{
                if !memoListViewModel.memos.isEmpty{
                    CustomNavigationBar(
                        isDisplayLeftBtn : false,
                        rightBtnAction: {
                            memoListViewModel.navigationRightBtnTapped()
                        },
                        rightBtnType: memoListViewModel.navigationBarRightBtnMode
                    )
                } else {
                    Spacer()
                        .frame(height: 30)
                    
                }
                //title view
                
                    //안내뷰 혹은 메모리스트 컨텐츠 뷰
                
                //메모작성 플로팅 아이콘 버튼뷰
                
            }
        }
        }
}

#Preview {
    MemoListView()
}
