//
//  User.swift
//  BaseMVVM
//
//  Created by Lê Thọ Sơn on 1/5/20.
//  Copyright © 2020 thoson.it. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {
    var id: Int = 0
    var avatarUrl : String = ""
    var name: String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id                  <- map["id"]
        avatarUrl           <- map["avatar_url"]
        name                <- map["name"]
    }
}
