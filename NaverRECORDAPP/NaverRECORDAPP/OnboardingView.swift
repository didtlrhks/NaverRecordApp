//
//  OnboardingView.swift
//  NaverRECORDAPP
//
//  Created by 양시관 on 1/5/24.
//

import Foundation
import SwiftUI


struct OnboardingView: View {
    @StateObject private var onboardingViewModel = OnboardingViewModel()
    
    
    var body: some View {
        //Todo: - 화면 전환구현 필요
        OnboardingContentView(onboardingViewModel: onboardingViewModel)
        
        
        
    }
}
//아 뭐냐
// MARK: - 온보딩 컨텐츠 뷰
private struct OnboardingContentView: View {
    
    @ObservedObject private var onboardingViewModel : OnboardingViewModel
    
    fileprivate init(onboardingViewModel: OnboardingViewModel) {
        self.onboardingViewModel = onboardingViewModel
    }
    
    fileprivate var body: some View{
        VStack{
            //온보딩 셀리스트뷰
            OnboardingCellListView(onboardingViewModel: onboardingViewModel)
            // 시작 버튼뷰
        }
    }
}
//MARK : - 온보딩 셀 리스트 뷰
private struct OnboardingCellListView : View{
    @ObservedObject private var onboardingViewModel : OnboardingViewModel
    @State private var selectedIndex : Int
    
    fileprivate
    init(onboardingViewModel: OnboardingViewModel,
        selectedIndex: Int = 0
    ) {
        self.onboardingViewModel = onboardingViewModel
        self.selectedIndex = selectedIndex
    }
    
    fileprivate var body: some View{
        TabView(selection: $selectedIndex){
            ForEach(Array(onboardingViewModel.onboardingContents.enumerated()),id : \.element){
               index, onboardingContent in
                OnboardingCellView(onboardingContent: onboardingContent)
                    .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height / 1.5)
        .background(
        selectedIndex % 2 == 0
        ? Color.customBackgroundGreen
        : Color.customBackgroundGreen
        
        )
        .clipped()
    }
}

//MARK : - 온보딩 셀 뷰
private struct OnboardingCellView : View{
    private var onboardingContent: OnboardingContent
    
    fileprivate init(onboardingContent: OnboardingContent){
        self.onboardingContent = onboardingContent
    }
    
    fileprivate var body: some View{
        VStack{
            Image(onboardingContent.imageFileName)
                .resizable()
                .scaledToFit()
            
            
            HStack{
                Spacer()
                VStack{
                    Spacer()
                        .frame(height: 46)
                    
                    Text(onboardingContent.title)
                        .font(.system(size: 16,weight: .bold))
                    
                    Spacer()
                        .frame(height: 5)
                    
                    Text(onboardingContent.subTitle)
                        .font(.system(size: 16))
                }
                
                Spacer()
            }
            .background(Color.customWhite)
            .cornerRadius(0)
        }
        .shadow(radius: 10)
    }
}


#Preview {
    OnboardingView()
}
