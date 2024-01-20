
import SwiftUI

struct TodoListView: View {
  @EnvironmentObject private var pathModel: PathModel//인바이러먼트옵젝트를 사용해서 전역처럼 사용하려고 호출을 해주는거임
  @EnvironmentObject private var todoListViewModel: TodoListViewModel
    @EnvironmentObject private var homeViewModel : HomeViewModel
  
  
  var body: some View { // 바디 부분
  
      // 투두 셀 리스트
      VStack {
        if !todoListViewModel.todos.isEmpty { // 투두리스트뷰모델에 투두가 비지않았을때 즉 투두가없으면 비어있자나 그러니까 넣는거임
          CustomNavigationBar( // 내가 커스텀한 네비게이션의 바에서 내가 어떤 걸 가져올지를 정하는거임
            isDisplayLeftBtn: false,
            rightBtnAction: {
              todoListViewModel.navigationRightBtnTapped()
            },
            rightBtnType: todoListViewModel.navigationBarRightBtnMode // 내가 만들어놓은 버튼들의 상태를 조건에 맞춰 지정해주는거임
          )
        } else { //그거에나리면 투두리스트가 비었을대니까 이럴땐 투두가없을거아냐 그러니까 공백을 만들어주는거지 어차피 이부분을 쓸일이없으니까
          Spacer()
            .frame(height: 30)
        }
        
        TitleView()
          .padding(.top, 20)
        
        if todoListViewModel.todos.isEmpty {
          AnnouncementView()
        } else {
          TodoListContentView()
            .padding(.top, 20) // 이제 이정도는 가볍다 접근해서 빈경우랑 안빈경우 구분해서 해줌
        }
      }
      
     
      .writeBtn {//클로저로 만든함수 해당파일에서 자세한 설명을 달자
          pathModel.paths.append(.todoView) // 음 이부분에서는 투두뷰로 가는 부분을 append 로 부여서 구현을 해놓은거지
      }
    .alert(
      "To do list \(todoListViewModel.removeTodosCount)개 삭제하시겠습니까?",
      isPresented: $todoListViewModel.isDisplayRemoveTodoAlert // isPresented로 화면에 보이는걸 지정해주는거고
    ) {
      Button("삭제", role: .destructive) { // 이녀석들이 그에 따른 조건들임
        todoListViewModel.removeBtnTapped()
      }
      Button("취소", role: .cancel) { }
    }
    .onChange(//온체인지는 내가 관찰하는 녀석과 그녀석이 바뀌었을때 어떤 액션을 할것인가를 지정해주는녀석임
      of: todoListViewModel.todos, // 얘가 관찰하는 녀석임 얘가 이제 변할때마다 밑에 클로저를 호출할거임
      perform: { todos in
          homeViewModel.setTodosCount(todos.count) // 이클로저는 함수 외부에서 어떻게 값을 변화시키는지를 알려주고 그에대한 행동을 진행함
      }
    )
  }
}

// MARK: - TodoList 타이틀 뷰
private struct TitleView: View {
  @EnvironmentObject private var todoListViewModel: TodoListViewModel// 이뷰에서 활용할 데이터셋을 지정 전역변수느낌
  
  fileprivate var body: some View { // 이파일안에서만 사용가능한 private 선언
    HStack {
      if todoListViewModel.todos.isEmpty {
        Text("To do list를\n추가해 보세요.")
      } else {
        Text("To do list \(todoListViewModel.todos.count)개가\n있습니다.")
      }
      
      Spacer()
    }
    .font(.system(size: 30, weight: .bold))
    .padding(.leading, 20)
  }
} // 이 뷰같은경우는 모두 다루긴했던 내용들 이제 슬슬 많이 없다 ㅋㅋ

// MARK: - TodoList 안내 뷰
private struct AnnouncementView: View {
  fileprivate var body: some View {
    VStack(spacing: 15) {
      Spacer()
      
      Image("pencil")
        .renderingMode(.template) // 이거는 렌더링 템플릿모드인데 이게 투명성을 바탕으로 색의 대비를 나타내주는거같음
      Text("\"매일 아침 5시 운동하자!\"")
      Text("\"내일 8시 수강 신청하자!\"")
      Text("\"1시 반 점심약속 리마인드 해보자!\"")
      
      Spacer()
    }
    .font(.system(size: 16))
    .foregroundColor(.customGray2)
  }
}

// MARK: - TodoList 컨텐츠 뷰
private struct TodoListContentView: View {
  @EnvironmentObject private var todoListViewModel: TodoListViewModel
  
  fileprivate var body: some View {
    VStack {
      HStack {
        Text("할일 목록")
          .font(.system(size: 16, weight: .bold))
          .padding(.leading, 20)
        
        Spacer()
      }
      
      ScrollView(.vertical) {
        VStack(spacing: 0) {
          Rectangle()
            .fill(Color.customGray0)
            .frame(height: 1)
          
          ForEach(todoListViewModel.todos, id: \.self) { todo in
            TodoCellView(todo: todo)
              
              // 너무쉽고 사실 그냥 뷰단임 약간 생각할거라고는 ForEach dㅔ서 id 부분을 self 로 ㄱ지정한다 정도 TodoCellView 로 돌리는 느낌이겠지
          }
        }
      }
    }
  }
}

// MARK: - Todo 셀 뷰
private struct TodoCellView: View {
  @EnvironmentObject private var todoListViewModel: TodoListViewModel
  @State private var isRemoveSelected: Bool
  private var todo: Todo
  
  fileprivate init(
    isRemoveSelected: Bool = false,
    todo: Todo
  ) {
    _isRemoveSelected = State(initialValue: isRemoveSelected)
    self.todo = todo
  }
  
  fileprivate var body: some View {
    VStack(spacing: 20) {
      HStack {
        if !todoListViewModel.isEditTodoMode {
          Button(
            action: { todoListViewModel.selectedBoxTapped(todo) },
            label: { todo.selected ? Image("selectedBox") : Image("unSelectedBox") }
          )
        }
        
        VStack(alignment: .leading, spacing: 5) {
          Text(todo.title)
            .font(.system(size: 16))
            .foregroundColor(todo.selected ? .customIconGray : .customBlack)
            .strikethrough(todo.selected)
          
          Text(todo.convertedDayAndTime)
            .font(.system(size: 16))
            .foregroundColor(.customIconGray)
        }
        
        Spacer()
        
        if todoListViewModel.isEditTodoMode {
          Button(
            action: {
              isRemoveSelected.toggle()
              todoListViewModel.todoRemoveSelectedBoxTapped(todo)
            },
            label: {
              isRemoveSelected ? Image("selectedBox") : Image("unSelectedBox")
            }
          )
        }
      }
      .padding(.horizontal, 20)
      .padding(.top, 10)
      
      Rectangle()
        .fill(Color.customGray0)
        .frame(height: 1)
    }
  }
}

// MARK: - Todo 작성 버튼 뷰
private struct WriteTodoBtnView: View {
  @EnvironmentObject private var pathModel: PathModel
  
  fileprivate var body: some View {
    VStack {
      Spacer()
      
      HStack {
        Spacer()
        
        Button(
          action: {
            pathModel.paths.append(.todoView)
          },
          label: {
            Image("writeBtn")
          }
        )
      }
    }
  }
}

struct TodoListView_Previews: PreviewProvider {
  static var previews: some View {
    TodoListView()
      .environmentObject(PathModel())
      .environmentObject(TodoListViewModel())
  }
}
