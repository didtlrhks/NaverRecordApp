//
//  OnboardingContent.swift
//  NaverRECORDAPP
//
//  Created by 양시관 on 1/5/24.
//

import Foundation
import SwiftUI


struct OnboardingContent : Hashable{
    
    var imageFileName: String
    var title : String
    var subTitle: String
    
    init(
        imageFileName : String,
        title : String,
        subTitle: String
    )
    {
        self.imageFileName = imageFileName
        self.title = title
        self.subTitle = subTitle
    }
}
