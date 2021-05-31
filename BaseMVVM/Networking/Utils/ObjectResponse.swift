//
//  ObjectResponse.swift
//  BaseMVVM
//
//  Created by Lê Thọ Sơn on 4/28/20.
//  Copyright © 2020 thoson.it. All rights reserved.
//

import Foundation
import ObjectMapper

class ObjectResponse<T: Mappable>: Mappable {
    var status: Bool = true
    var code: Int = 0
    var message: String = ""
    var data: T?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        status          <- map["status"]
        code            <- map["code"]
        message         <- map["message"]
        //        data            <- map["data"]
        data = T(map: map)
        data?.mapping(map: map)
    }
}

