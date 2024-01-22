//
//  MemoListViewModel.swift
//  NaverRECORDAPP
//
//  Created by 양시관 on 1/8/24.
//

import Foundation

class MemoListViewModel : ObservableObject { // 옵서버블옵젝트를 따르는 클래스를 선언해줌 이유는 옵저버블 옵젝트를 가지고있는 다른 데이터모델들을 사용해야하기때문임
    @Published var memos : [Memo] //퍼블리쉬드로 Memo 데이터를 memos 에 넣어서 이클래스에서 memos 로 Memo 데이터에 접근할수있도록 해준다,
    @Published var isEditMemoMode : Bool //이것도 마찬가지로 이 클래스 내부에서 isEditMeomoMode 를 bool값으로 선언해서 상태를 조절해주려는 구현임
    @Published var removeMemos : [Memo] // ""
    @Published var isDisplayRemoveMemoAlert : Bool // ""
    
    var removeMemoCount : Int { // 인트형으로 값이 나올것을 암시해주고
        return removeMemos.count//removeMemo로 들어가서 .conunt 라는 인스턴스를 불러줌 보라색글씨니까 그냥 지원해주는거임 count 새주는거
    } // 코드 블럭으로 저장은 하지않는 값이 변경되면 그냥 계산된 값을 던져주는 코드 블럭
    
    var navigationBarRightBtnMode : NavigationBtnType { // 네비게이션 버튼 타입으로 리턴값을 주는거임
        isEditMemoMode ? .complete : .edit // 여기서 처럼 NavigationBtnType 이거를 주면 isEditMemoMode 가 참이면 complete 를 반환 아니면 에딧모드를 반환해서 쓰게해줌 이 인스턴스들이 NavigationBtnType 여기서 나온것들이라 이렇게 구현을 한거임
    }
    init(memos : [Memo] = [],
         isEditMemoMode: Bool = false,
         removeMemos: [Memo] = [],
         isDisplayRemoveMemoAlert: Bool = false
    )
    {
        self.memos = memos
        self.isEditMemoMode = isEditMemoMode
        self.removeMemos = removeMemos
        self.isDisplayRemoveMemoAlert = isDisplayRemoveMemoAlert
    } // 초기화해주고 자기클래스의 자기자신을 인스턴스화 해준거임
}

extension MemoListViewModel { // 익스텐션으로 추가기능 만들어줬고 
    func addMemo(_ memo : Memo) {
        memos.append(memo)
    }
    
    func updateMemo(_ memo: Memo) {
        if let index = memos.firstIndex(where: { $0.id == memo.id}){
            memos[index] = memo
        }
    }
    
    func removeMemo(_ memo: Memo) {
        if let index = memos.firstIndex(where: { $0.id == memo.id}) {
            memos.remove(at : index)
        }
    }
    
    func navigationRightBtnTapped() {
        if isEditMemoMode {
            if removeMemos.isEmpty {
                isEditMemoMode = false
                
            }else {
                //삭제 알럿 상태값 변경을 위한 메서드 호출
                setIsDisplayRemoveMemoAlert(true)
            }
        } else {
            isEditMemoMode = true
        }
    }
    
    func setIsDisplayRemoveMemoAlert(_ isDisplay : Bool ){
        isDisplayRemoveMemoAlert = isDisplay
    }
    
    func memoRemoveSelectedBoxTapped(_ memo : Memo) {
        if let index = removeMemos.firstIndex(of : memo){
            removeMemos.remove(at: index)
        } else {
            removeMemos.append(memo)
        }
    }
    
    func removeBtnTapped() {
        memos.removeAll() {
            memo in
            removeMemos.contains(memo)
        }
        removeMemos.removeAll()
        isEditMemoMode = false
    }
}
