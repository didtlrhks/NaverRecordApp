//
//  CustomNavigationBar.swift
//  NaverRECORDAPP
//
//  Created by 양시관 on 1/7/24.
//

import Foundation
import SwiftUI

struct CustomNavigationBar : View {
    
    let isDisplayLeftBtn : Bool
    let isDisplayRightBtn : Bool
    let leftBtnAction : () -> Void
    let rightBtnType : NavigationBtnType
    let rightBtnAction : () -> Void
    
    init(
        isDisplayLeftBtn: Bool = true, isDisplayRightBtn: Bool = true,
        leftBtnAction: @escaping () -> Void = {},
        rightBtnAction : @escaping () -> Void = {},
        rightBtnType: NavigationBtnType = .edit
    )
    {
        self.isDisplayLeftBtn = isDisplayLeftBtn
        self.isDisplayRightBtn = isDisplayRightBtn
        self.leftBtnAction = leftBtnAction
        self.rightBtnType = rightBtnType
        self.rightBtnAction = rightBtnAction
    }
    
    var body: some View {
        HStack{
            if isDisplayLeftBtn {
                Button (
                    action : leftBtnAction,
                    label: {
                        Image("leftArrow")
                    }
                )

            }
            
            Spacer()
            
            
            if isDisplayRightBtn {
                Button (
                    action : rightBtnAction,
                    label: {
                        if  rightBtnType == .close {
                            Image("close")
                        }
                        else{
                            Text(rightBtnType.rawValue)
                                .foregroundColor(.customBlack)
                        }
                    }
                )
            }
            }
        .padding(.horizontal , 20)
        .frame(width: 20)
        Text("CustomNavigationBar")
    }
}


struct CustomNavigationBar_Previews: PreviewProvider{
    static var previews: some View{
        CustomNavigationBar()
    }
}
 
