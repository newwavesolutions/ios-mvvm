//
//  MainViewModel.swift
//  BaseMVVM
//
//  Created by Lê Thọ Sơn on 1/4/20.
//  Copyright © 2020 thoson.it. All rights reserved.
//

import Foundation
import RxCocoa

class SplashViewModel: ViewModel {
    private let navigator: SplashNavigator
    
    init(navigator: SplashNavigator) {
        self.navigator = navigator
        super.init(navigator: navigator)
        
        if AuthManager.shared.loggedIn.value {
            navigator.pushHome()
        } else {
            navigator.pushSignIn()
        }
    }
}
