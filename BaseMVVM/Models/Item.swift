//
//  Repository.swift
//  BaseMVVM
//
//  Created by Lê Thọ Sơn on 1/5/20.
//  Copyright © 2020 thoson.it. All rights reserved.
//

import Foundation
import ObjectMapper

class Item: Mappable {
    var id: String = ""
    var name: String = ""
    var fullName: String = ""
    var description: String = ""
    private var _thumbnail: String = ""
    var thumbnail: String {
        return "https://image.tmdb.org/t/p/w185" + _thumbnail
    }
    var createdAt: String = ""
    var updatedAt: String = ""
    var pushedAt: String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id                  <- map["id"]
        name                <- map["title"]
        fullName            <- map["title"]
        description         <- map["overview"]
        _thumbnail          <- map["poster_path"]
        createdAt           <- map["created_at"]
        updatedAt           <- map["updated_at"]
        pushedAt            <- map["pushed_at"]
    }
}
