//
//  File.swift
//  NaverRECORDAPP
//
//  Created by 양시관 on 1/7/24.
//

import Foundation


class TodoListViewModel : ObservableObject {//뷰모델을 만들어서 Todo 에 있는녀석 가져와서 뷰모델에서 뷰에 넣기 전에 데이터들을 잘 처리해준다 이렇게 해주는게 MVVM 패턴인거거덩
    
    
    @Published var todos : [Todo]
    @Published var isEditTodoMode : Bool
    @Published var removeTodos : [Todo]
    @Published var isDisplayRemoveTodoAlert : Bool
    
    var removeTodosCount : Int {
        return removeTodos.count // 여기 카운트는 그냥 제공하는녀석이네 이걸 왜의심했냐면 removeTodos 에 갔는데 데이터셋 Todo 를 가지고있어서 가봤더니 count 가 없네 그래서 count 를 의심했음
        // 여튼 그렇게 해서 INt 형식으로 이번엔 값을 저장을 해주네 ㅇㅇ 아까 전에는 저장안하고 변하면 바로계산해서 쏴주기만했자나
    }
    var navigationBarRightBtnMode : NavigationBtnType { // 네비게이션 버튼타입에 가서 내가쓰고싶은 열거형 ㅌ친구들을 잘써준 모습
        isEditTodoMode ? .complete: .edit // 기본문법이니까 패스 ? 후 참이면 1 flase 면 두번째거
    }
    init(todos: [Todo] = [],
         isEditModeTodoMode: Bool = false,
         removeTodos: [Todo] = [],
         isDisplayRemoveTodoAlert: Bool = false
        )
    {
        self.todos = todos
        self.isEditTodoMode = isEditModeTodoMode
        self.removeTodos = removeTodos
        self.isDisplayRemoveTodoAlert = isDisplayRemoveTodoAlert
     
    }
    
}

extension TodoListViewModel {
    
    func selectedBoxTapped(_ todo: Todo) {
        if let index = todos.firstIndex(where: { $0 == todo }) {
            todos[index].selected.toggle()
        }
    }
    
    func addTodo(_ todo: Todo) {
        todos.append(todo)
    }
    
    func navigationRightBtnTapped() {
        if isEditTodoMode {
            if removeTodos.isEmpty {
                isEditTodoMode = false
            }
            else {
               setIsDisplayRemoveTodoAlert(true)
            }
        }else {
            isEditTodoMode = true
        }
    }
    
    
    func setIsDisplayRemoveTodoAlert(_ isDisplay: Bool) {
        isDisplayRemoveTodoAlert = isDisplay
    }
    
    func todoRemoveSelectedBoxTapped(_ todo: Todo) {
        if let index = removeTodos.firstIndex(of: todo) {
            removeTodos.remove(at: index)}
        else {
            removeTodos.append(todo)
        }
    }
    
    func removeBtnTapped() {
        todos.removeAll {
             todo in
            removeTodos.contains(todo)
        }
        removeTodos.removeAll()
        isEditTodoMode = false
    }
}
