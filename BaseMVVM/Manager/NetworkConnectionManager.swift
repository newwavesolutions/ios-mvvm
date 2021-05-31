//
//  NetworkConnectionManager.swift
//  BaseMVVM
//
//  Created by Lê Thọ Sơn on 4/25/20.
//  Copyright © 2020 thoson.it. All rights reserved.
//

import Foundation
import RxCocoa
import Alamofire
import Network

class NetworkConnectionManager {
    static let shared = NetworkConnectionManager()
    let isConnected = BehaviorRelay<Bool>(value: false)
    
    let reachabilityManager = NetworkReachabilityManager()
    
    init() {
        reachabilityManager?.startListening(onUpdatePerforming: { [weak self] status in
            guard let self = self else { return }
            switch status {
            case .reachable(.ethernetOrWiFi):
                log.info("The connection type is either over Ethernet or WiFi.")
                self.isConnected.accept(true)
                break
            case .reachable(.cellular):
                log.info("The connection type is a cellular connection.")
                self.isConnected.accept(true)
                break
            case .notReachable:
                log.info("The network is not reachable.")
                self.isConnected.accept(false)
                break
            case .unknown:
                log.info("It is unknown whether the network is reachable.")
                self.isConnected.accept(false)
                break
            }
        })
    }
}

//@available(iOS 12.0, *)
//private class NewConnectionManager: NSObject {
//    let monitor = NWPathMonitor()
//    override init() {
//        monitor.pathUpdateHandler = { path in
//            if path.status == .satisfied {
//                logDebug("We're connected!")
//            } else {
//                logDebug("No connection.")
//            }
//
//            print(path.isExpensive)
//        }
//        let queue = DispatchQueue.global(qos: .background)
//        monitor.start(queue: queue)
//    }
//}
