//
//  PathModel.swift
//  NaverRECORDAPP
//
//  Created by 양시관 on 1/6/24.
//

import Foundation


class PathModel : ObservableObject {
    @Published var paths : [PathType]
    
    init(paths : [PathType] = []){
        self.paths = paths
    }
}
