//
//  ArrayResponse.swift
//  BaseMVVM
//
//  Created by Lê Thọ Sơn on 4/28/20.
//  Copyright © 2020 thoson.it. All rights reserved.
//

import Foundation
import ObjectMapper

class ArrayResponse<T: Mappable>: Mappable {
    var page: Int = 1
    var totalResults: Int = 0
    var totalPages: Int = 0
    var results: [T] = []
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        page                <- map["page"]
        totalResults        <- map["total_results"]
        totalPages          <- map["total_pages"]
        results             <- map["results"]
    }
}
