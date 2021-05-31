//
//  Response+ObjectMapper.swift
//  BaseMVVM
//
//  Created by Lê Thọ Sơn on 1/5/20.
//  Copyright © 2020 thoson.it. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper

extension Response {
    
    /// Maps data received from the signal into an object which implements the Mappable protocol.
    /// If the conversion fails, the signal errors.
    func mapObject<T: BaseMappable>(_ type: T.Type, context: MapContext? = nil) throws -> T {
        guard let object = Mapper<T>(context: context).map(JSONObject: try mapJSON()) else {
            throw MoyaError.jsonMapping(self)
        }
        return object
    }
    
    /// Maps data received from the signal into an array of objects which implement the Mappable
    /// protocol.
    /// If the conversion fails, the signal errors.
    func mapArray<T: BaseMappable>(_ type: T.Type, context: MapContext? = nil) throws -> [T] {
        guard let array = try mapJSON() as? [[String : Any]] else {
            throw MoyaError.jsonMapping(self)
        }
        return Mapper<T>(context: context).mapArray(JSONArray: array)
    }
    
    //Use bellow if need

//    /// Maps data received from the signal into an object which implements the Mappable protocol.
//    /// If the conversion fails, the signal errors.
//    func mapObject<T: BaseMappable>(_ type: T.Type, atKeyPath keyPath: String, context: MapContext? = nil) throws -> T {
//        guard let object = Mapper<T>(context: context).map(JSONObject: (try mapJSON() as? NSDictionary)?.value(forKeyPath: keyPath)) else {
//            throw MoyaError.jsonMapping(self)
//        }
//        return object
//    }
//
//    /// Maps data received from the signal into an array of objects which implement the Mappable
//    /// protocol.
//    /// If the conversion fails, the signal errors.
//    func mapArray<T: BaseMappable>(_ type: T.Type, atKeyPath keyPath: String, context: MapContext? = nil) throws -> [T] {
//        guard let array = (try mapJSON() as? NSDictionary)?.value(forKeyPath: keyPath) as? [[String : Any]] else {
//            throw MoyaError.jsonMapping(self)
//        }
//        return Mapper<T>(context: context).mapArray(JSONArray: array)
//    }
}
