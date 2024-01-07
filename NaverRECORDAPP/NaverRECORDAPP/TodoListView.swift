//
//  TodoListView.swift
//  NaverRECORDAPP
//
//  Created by 양시관 on 1/7/24.
//

import SwiftUI

struct TodoListView: View {
    
    @EnvironmentObject private var pathModel : PathModel
    @EnvironmentObject private var todoListViewModel : TodoListViewModel
    
    
    var body: some View {
        ZStack{
            //Todo : todoListCellList
            VStack{
                if !todoListViewModel.todos.isEmpty {
                    CustomNavigationBar(
                      isDisplayLeftBtn: false,
                      rightBtnAction: {
                          todoListViewModel.navigationRightBtnTapped()
                          
                      },
                      rightBtnType: todoListViewModel.navigationBarRightBtnMode
                      
                    )
                }else {
                    Spacer()
                        .frame(height: 30)
                }
                
                TitleView()
                AnnouncementView()
            }
        }

    }
}

private struct TitleView : View {
    @EnvironmentObject private var todoListViewModel : TodoListViewModel
    
    fileprivate var body: some View{
        HStack{
            if todoListViewModel.todos.isEmpty {
                Text("todo list를 \n 추가해보세요.")
            }
            else {
                Text("Todo List \(todoListViewModel.todos.count) 개가 \n있습니다.")
            }
            Spacer()
        }
        .font(.system(size: 30,weight: .bold))
        .padding(.leading,20)
    }
}


//MARK : - TodoList 안내뷰
private struct AnnouncementView : View {
    fileprivate var body: some View{
        VStack(spacing : 15) {
            Spacer()
            
            Image("pencil")
                .renderingMode(.template)
            Text("\" 매일 아침 5시 운동가라고 알려줘!\"")
            Text("\" 내일 8시 수강신청하자!\"")
            Text("\" 1시반 점심약속 리마인드 해보자!\"")
            
            Spacer()
        }
        .font(.system(size: 16))
        .foregroundColor(.customGray2)
    }
}

// MARK : -TOdoList컨텐츠 뷰
private struct TodoListContentView : View {
    
    @EnvironmentObject private var todoListViewModel : TodoListViewModel
    var body: some View {
        VStack{
            HStack{
                Text("할일목록")
                
            }
        }
    }
}

#Preview {
    TodoListView()
        .environmentObject(PathModel())
        .environmentObject(TodoListViewModel())
}
