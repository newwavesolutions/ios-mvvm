//
//  Token.swift
//  BaseMVVM
//
//  Created by Lê Thọ Sơn on 4/25/20.
//  Copyright © 2020 thoson.it. All rights reserved.
//

import Foundation
import ObjectMapper

struct Token: Mappable {
    var accessToken: String?
    var refreshToken: String?
    
    init?(map: Map) {}
    init() {}
    
    mutating func mapping(map: Map) {
        accessToken         <- map["access_token"]
        refreshToken        <- map["refresh_token"]
    }
}
