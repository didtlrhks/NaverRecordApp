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
                TitleView()
                
                    //안내뷰 혹은 메모리스트 컨텐츠 뷰
                
                //메모작성 플로팅 아이콘 버튼뷰
                
            }
        }
        }
}

private struct TitleView : View {
    @EnvironmentObject private var memoListViewModel : MemoListViewModel
    
    fileprivate var body: some View {
        HStack{
            if memoListViewModel.memos.isEmpty {
                Text("메모를\n추가해 보세요.")
            }else {
                Text("메모 \(memoListViewModel.memos.count)개가 \n있습니다.")
            }
            Spacer()
        }
        .font(.system(size:30,weight: .bold))
        .padding(.leading, 20)
    }
}

private struct AnnouncementView:View {
    fileprivate var body: some View {
        VStack(spacing : 15) {
            Spacer()
            
            Image("pencil")
                .renderingMode(.template)
            Text("\"퇴근 9시간전 메모\"")
            Text("\"개발 끝낸 후 퇴근하기!\"")
            Text("\"밀린 알고리즘 공부하기!\"")
            
            Spacer()
            
            
        }
        .font(.system(size:16))
        .foregroundColor(.customGray2)
    }
}



#Preview {
    MemoListView()
        .environmentObject(PathModel())
        .environmentObject(MemoListViewModel())
}
