//
//  LibsManager.swift
//  BaseMVVM
//
//  Created by Lê Thọ Sơn on 3/29/20.
//  Copyright © 2020 thoson.it. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SwiftyBeaver

/// The manager class for configuring all libraries used in app.
class LibsManager: NSObject {
    /// The default singleton instance.
    static let shared = LibsManager()
    
    override init() {
        super.init()
        
    }
    
    func setupLibs(with window: UIWindow? = nil) {
        let libsManager = LibsManager.shared
        libsManager.setupKeyboardManager()
        libsManager.setupLogManager()
    }
    
    
    func setupKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
    
    func setupLogManager() {
        #if DEBUG
        let console = ConsoleDestination()
        log.addDestination(console)
        #endif
    }
}
