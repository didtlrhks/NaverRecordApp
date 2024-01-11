//
//  WriteBtn.swift
//  NaverRECORDAPP
//
//  Created by 양시관 on 1/11/24.
//

import Foundation
import SwiftUI

extension View {
    public func writeBtn(perform action: @escaping () -> Void) -> some View {
        ZStack{
            self
            
            VStack{
                Spacer()
                
                HStack{
                    Spacer()
                    
                    Button(action: action, label: {
                        Image("writeBtn")
                    })
                }
            }
        }.padding(.trailing,20)
            .padding(.bottom,50)
    }
}
