//
//  HomeView.swift
//  NaverRECORDAPP
//
//  Created by 양시관 on 1/6/24.
//

import Foundation
import SwiftUI


struct HomeView: View {
  @EnvironmentObject private var pathModel: PathModel // 내가 이해한 개념으로는. Pathmodel 이 옵저버블옵젝트를 따라야만 이게 가능함 이유는 부모와 자식간의 데이터공유기능임 예를 들어 PathModel 에서 허락?) 개념을 해나가야만 여기서 이걸 쓸수있음 여기서 변경이되고 패쓰모델에서도 데이터값을 줄 수가 있다 이런이유로 인바이론먼트 옵젝트를 사용한다 그럼 왜 private ?
    //private를 사용하는 이유는 pathModel 이 해당 클래스및 구조체에서만 사용이가능하기 떄문임
    
  @StateObject private var homeViewModel = HomeViewModel()// 사실 이해한 결과로는 거의 ObservedObject랑 State랑은 거의 비슷하다 근데 화면이 유지가되냐 안되냐에 싸움같음 예를 들면 내가 어떤 횟수를 세고있다가 다른 횟수를 세는 버튼을 눌렀어 그럼 원래꺼는 지워지면 안됬잖아 근데 사라지는거지 즉 상태가 다시 새로고침되자나 이런경우가 ObservedObject 이경우인거야 근데 state를 사용한다고 해봐 그럼 기존에있는 객체는 사라지지않는다는걸 의미하니까 기존 숫자새는거는 유지되고 다른건 초기화가 되는거지 즉 이걸여기에다가 선언해놨다는거는 homeViewModel 이걸 사용할대 기존 뷰는 유지를 하면서 데이터값을 변경하거싶다. 이런의미가 담겨있는거지
  
  var body: some View {
    ZStack { // zstack 은 가로 세로축이 아닌 z 축으로 올라오는 녀석인거지 이녀석이 있어야만 밑에있는 x,y축들에 뷰에 간섭받지않고 띄워져서 사용할 수 있음
      TabView(selection: $homeViewModel.selectedTab) { //탭뷰가 있다 일단 문법은 이렇게 사용하면 될거같고 일단 selection 으로 일단 내가 어떤거를 selecte 하는지를 확인하는 문법이고 바인딩을 하는 문법은 $를 사용하고 homeViewModel 이라는 모델에 들어가서 . 연산문법으로 인스턴스에 접근하는 문법이자나 그럼 그안에 있는 selectedTab 이라는 인스턴스에 들어가있는거지 그래서 이렇게 접근한다
        TodoListView() //TodoList로 넘어가는 옵션이야 이걸로 넘어가는거지
          .tabItem { // 탭아이템 모디파이어를 사용해서 탭에 표시될 내용을 정의할 수 있는거다
            Image(// 이미지를 넣어주는 녀석이다.
              homeViewModel.selectedTab == .todoList//여기서는 홈뷰모델에 셀렉트탭이라는 인스턴스를 데려와서 이거랑 투두리스트라는 것을 같은경우에
              ? "todoIcon_selected"// 트루라면 이 이미지를 올려주고
              : "todoIcon"//트루가 아니라면 이 이미지를 선택해준다.
            )
          }
          .tag(Tab.todoList) // 태그로 탭이라는 열겨형을 만들어서 . 연산자로 인스턴스에 접근해서 todolist 라는 열겨형 인스턴스에 고유한 태그를 달아주는거임
        
        MemoListView() //메모리스트뷰를 호출해줌
          .tabItem {
            Image(
              homeViewModel.selectedTab == .memo
              ? "memoIcon_selected"
              : "memoIcon"
            )
          }
          .tag(Tab.memo)
        
        VoiceRecorderView()
          .tabItem {
            Image(
              homeViewModel.selectedTab == .voiceRecorder
              ? "recordIcon_selected"
              : "recordIcon"
            )
          }
          .tag(Tab.voiceRecorder)
        
        TimerView()
          .tabItem {
            Image(
              homeViewModel.selectedTab == .timer
              ? "timerIcon_selected"
              : "timerIcon"
            )
          }
          .tag(Tab.timer)
        
        SettingView()
          .tabItem {
            Image(
              homeViewModel.selectedTab == .setting
              ? "settingIcon_selected"
              : "settingIcon"
            )
          }
          .tag(Tab.setting)
      }
      .environmentObject(homeViewModel) // 일단 이녀석이 어떤 하위뷰들에게 homeViewModel 에 대한 데이터에 접근을 할수있게해주는건데 내가 궁금한건왜 마지막 TabView 에 마지막 괄호에 이런 녀석이 찍혀있는지 궁금했는데 이렇게 하면 TabView 사이에있는 모든 뷰들의 하위에 homeModel 에대한 접근이 가능해지기때문에 이렇게 해논거라고 이해하게 됨
      
        SeperatorLineView()// 뷰올려놓기
    }
  }
}

// MARK: - 구분선
private struct SeperatorLineView: View { // private 를 사용해서 이 구조체로써 내가 이파일안에서만 접근가능함을 알림
    
  fileprivate var body: some View { // fileprivate 를 하는 이유는 이소스안에서만 접근하려는 프로퍼티에 접근하는거임
      VStack { // 새로 스택임
      Spacer()//거리를 주는거임 이런건 프레임으로 구분해줄수도있음
      
      Rectangle() // 사각형을 넣어주는거임
        .fill(// 사각형의 내부의 색상을 채워주는역할을 하는거임
          LinearGradient( // 색상의 순차적으로 변하는 역할을 이해시켜줌
            gradient: Gradient(colors: [Color.white, Color.gray.opacity(0.1)]), // 화이트에
            startPoint: .top,// 시작점
            endPoint: .bottom// 마무리점
          )
        )
        .frame(height: 10)
        .padding(.bottom, 60)
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
      .environmentObject(PathModel())
      .environmentObject(TodoListViewModel())
      .environmentObject(MemoListViewModel())
      //이녀석들은 홈뷰와 그 하위뷰들에서 사용할수있다는 데이터등 혹은 인스턴스들을 가져올수있도록 지정해주는것임
  }
}
