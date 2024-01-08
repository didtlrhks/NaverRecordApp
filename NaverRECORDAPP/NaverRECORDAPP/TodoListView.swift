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
                    .padding(.top,20)
                
                if todoListViewModel.todos.isEmpty{
                    AnnouncementView()
                }
                else {
                    TodoListContentView()
                        .padding(.top,20)
                }
                
            }
            WriteTodoBtnView()
                .padding(.trailing,20)
                .padding(.bottom,50)
        }
        .alert("To do list \(todoListViewModel.removeTodosCount) 개 삭제하시겠습니까?",
               isPresented: $todoListViewModel.isDisplayRemoveTodoAlert) {
            Button("삭제",role: .destructive) {
                todoListViewModel.removeBtnTapped()
            }
            Button("취소", role: .cancel){}
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
                    .font(.system(size: 16,weight: .bold))
                    .padding(.leading, 20)
                
                Spacer()
                
            }
            
            ScrollView(.vertical){
                VStack(spacing : 0){
                    Rectangle()
                        .fill(Color.customGray0)
                        .frame(height: 1)
                    
                    ForEach(todoListViewModel.todos, id: \.self) {
                        todo in
                        // Todo 셀뷰 todo 넣어서 뷰호출
                        TodoCellView(todo: todo)
                        
                    }
                }
            }
        }
    }
}

//todo cell view
private struct TodoCellView : View {
    @EnvironmentObject private var todoListViewModel : TodoListViewModel
    @State private var isRemoveSelected: Bool
    private var todo : Todo
    
    fileprivate init(
        isRemoveSelected: Bool = false,
        todo: Todo)
    {
        _isRemoveSelected = State(initialValue: isRemoveSelected)
        self.todo = todo
    }
    
    fileprivate var body: some View{
        VStack(spacing : 20){
            HStack{
                if !todoListViewModel.isEditTodoMode{
                    Button(
                        action: {todoListViewModel.selectedBoxTapped(todo)},
                        label: {todo.selected ? Image("selectedBox") : Image("unselectedBox")}
                    )
                }
                VStack(alignment: .leading, spacing: 5){
                    Text(todo.title)
                        .font(.system(size: 16))
                        .foregroundColor(todo.selected ? .customIconGray : .customBlack)
                    
                    Text(todo.convertedDayAndTime)
                        .font(.system(size: 16))
                        .foregroundColor(.customIconGray)
                }
                
                Spacer()
                
                if todoListViewModel.isEditTodoMode {
                    Button(
                        action : {
                            isRemoveSelected.toggle()
                            todoListViewModel.todoRemoveSelectedBoxTapped(todo)
                        },
                        label: {
                            isRemoveSelected ? Image("selectedBox") : Image("unSelectedBox")
                        }
                    )
                }
            }
            .padding(.horizontal,20)
            .padding(.top,10)
            
            Rectangle()
                .fill(Color.customGray0)
                .frame(height: 1)
        }
    }
}

// MARk : -TOdo 작성버튼뷰

private struct WriteTodoBtnView : View{
    @EnvironmentObject private var pathModel : PathModel
    
    fileprivate var body: some View {
        VStack{
            Spacer()
            HStack{
                Spacer()
                
                Button(
                    action: { pathModel.paths.append(.todoView)}
                    , label: {
                        Image("writeBtn")
                    })
            }
        }
    }
}

#Preview {
    TodoListView()
        .environmentObject(PathModel())
        .environmentObject(TodoListViewModel())
}



