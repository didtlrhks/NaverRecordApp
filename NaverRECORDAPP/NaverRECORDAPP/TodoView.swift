import SwiftUI

struct TodoView: View {
  @EnvironmentObject private var pathModel: PathModel // 패쓰모델을 인바이런먼트 옵젝트로 선언은 해주는데 private 네? 이는 캡슐화를 강화하기 위해서 하는거임 딱히 상관없음 그냥 Todd 안에서만 사용하면서 EnvironmentObject 이걸로 viewmodelㄹ의 데이터를 불러올수있게 하는거
  @EnvironmentObject private var todoListViewModel: TodoListViewModel
  @StateObject private var todoViewModel = TodoViewModel()//이거는 데이터바인딩의 개념이랑 같은데 () 이걸 쓴이유는 () 객체를 생성하는느낌으로 다가가는거지 근데 어차피 같은 데이터 바인딩임 Type 'TodoViewModel.Type' cannot conform to 'ObservableObject' 이런 오류가 남 () 이게 없으면 아마 ObservableObject 이걸 따르니까 새로운 객체를 만들어서 작업하는게 맞다고 되는듯
  
  var body: some View {
    VStack {
      CustomNavigationBar(
        leftBtnAction: {// 액션에다가 호출
          pathModel.paths.removeLast()//패스모델에 패스에 접근해서 removelast로 전거를 지워버림
        },
        rightBtnAction: {
          todoListViewModel.addTodo( // addtodo 함수를 호출해서 투두를 만들어주는거얌
            .init(
              title: todoViewModel.title,
              time: todoViewModel.time,
              day: todoViewModel.day,
              selected: false
            )
          )
          pathModel.paths.removeLast()
        },
        rightBtnType: .create // create 로 라이트버튼 타입에 액션 도달해주기
      )
      
      TitleView()
        .padding(.top, 20)
      
      Spacer()
        .frame(height: 20)
      
      TodoTitleView(todoViewModel: todoViewModel)
        .padding(.leading, 20)
      
      SelectTimeView(todoViewModel: todoViewModel)
      
      SelectDayView(todoViewModel: todoViewModel)
        .padding(.leading, 20)
      
      Spacer()
    }
  }
}

// MARK: - 타이틀 뷰
private struct TitleView: View {
  fileprivate var body: some View {
    HStack {
      Text("To do list를\n추가해 보세요.")
      
      Spacer()
    }
    .font(.system(size: 30, weight: .bold))
    .padding(.leading, 20)
  }
}

// MARK: - 투두 타이틀 뷰 (제목 입력 뷰)
private struct TodoTitleView: View {
  @ObservedObject private var todoViewModel: TodoViewModel // 이 구조체안에서 사용할 데이터모델 삽임해주고
  
  fileprivate init(todoViewModel: TodoViewModel) {
    self.todoViewModel = todoViewModel
  } // 초기화 설정해주기
  
  fileprivate var body: some View {
    TextField("제목을 입력하세요.", text: $todoViewModel.title) // 데이터 바인딩
  }
}

// MARK: - 시간 선택 뷰
private struct SelectTimeView: View {
  @ObservedObject private var todoViewModel: TodoViewModel
  
  fileprivate init(todoViewModel: TodoViewModel) {
    self.todoViewModel = todoViewModel
  }
  
  fileprivate var body: some View {
    VStack {
      Rectangle()
        .fill(Color.customGray0)
        .frame(height: 1)
      
      DatePicker(
        "",
        selection: $todoViewModel.time,// 여기서 선택하는것들은 todoViewModel 의 시간을 선택하는거고
        displayedComponents: [.hourAndMinute] // 시간과 분이 보이게 해준
      )
      .labelsHidden() // 레이블 안보이게하고
      .datePickerStyle(WheelDatePickerStyle()) // 휠 방식 
      .frame(maxWidth: .infinity, alignment: .center)
      
      Rectangle()
        .fill(Color.customGray0)
        .frame(height: 1)
    }
  }
}

// MARK: - 날짜 선택 뷰
private struct SelectDayView: View {
  @ObservedObject private var todoViewModel: TodoViewModel
  
  fileprivate init(todoViewModel: TodoViewModel) {
    self.todoViewModel = todoViewModel
  }
  
  fileprivate var body: some View {
    VStack(spacing: 5) {
      HStack {
        Text("날짜")
          .foregroundColor(.customIconGray)
        
        Spacer()
      }
      
      HStack {
        Button(
          action: { todoViewModel.setIsDisplayCalendar(true) },
          label: {
            Text("\(todoViewModel.day.formattedDay)")
              .font(.system(size: 18, weight: .medium))
              .foregroundColor(.green)
          }
        )
        .popover(isPresented: $todoViewModel.isDisplayCalendar) {
          DatePicker(
            "",
            selection: $todoViewModel.day,
            displayedComponents: .date
          )
          .labelsHidden()
          .datePickerStyle(GraphicalDatePickerStyle())
          .frame(maxWidth: .infinity, alignment: .center)
          .padding()
          .onChange(of: todoViewModel.day) { _ in
            todoViewModel.setIsDisplayCalendar(false)
          }
          
        }
        Spacer()
      }
    }
  }
}

struct TodoView_Previews: PreviewProvider {
  static var previews: some View {
    TodoView()
  }
}
