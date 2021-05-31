//
//  ObservableType+ObjectMapper.swift
//  BaseMVVM
//
//  Created by Lê Thọ Sơn on 1/5/20.
//  Copyright © 2020 thoson.it. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import ObjectMapper
/// Extension for processing Responses into Mappable objects through ObjectMapper
public extension ObservableType where Element == Response {
    
    /// Maps data received from the signal into an object
    /// which implements the Mappable protocol and returns the result back
    /// If the conversion fails, the signal errors.
    func mapObject<T: BaseMappable>(_ type: T.Type, context: MapContext? = nil) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(try response.mapObject(type, context: context))
        }
    }
    
    /// Maps data received from the signal into an array of objects
    /// which implement the Mappable protocol and returns the result back
    /// If the conversion fails, the signal errors.
    func mapArray<T: BaseMappable>(_ type: T.Type, context: MapContext? = nil) -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            return Observable.just(try response.mapArray(type, context: context))
        }
    }
    
    //Use bellow if need
    
    //  /// Maps data received from the signal into an object
    //  /// which implements the Mappable protocol and returns the result back
    //  /// If the conversion fails, the signal errors.
    //  public func mapObject<T: BaseMappable>(_ type: T.Type, atKeyPath keyPath: String, context: MapContext? = nil) -> Observable<T> {
    //    return flatMap { response -> Observable<T> in
    //      return Observable.just(try response.mapObject(T.self, atKeyPath: keyPath, context: context))
    //    }
    //  }
    //
    //  /// Maps data received from the signal into an array of objects
    //  /// which implement the Mappable protocol and returns the result back
    //  /// If the conversion fails, the signal errors.
    //    public func mapArray<T: BaseMappable>(_ type: T.Type, atKeyPath keyPath: String, context: MapContext? = nil) -> Observable<[T]> {
    //    return flatMap { response -> Observable<[T]> in
    //            return Observable.just(try response.mapArray(T.self, atKeyPath: keyPath, context: context))
    //    }
    //  }
}
