//
//  HomeViewModel.swift
//  BaseMVVM
//
//  Created by Lê Thọ Sơn on 4/21/20.
//  Copyright © 2020 thoson.it. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel: ViewModel {
    // MARK: Public Properties
    
    // MARK: Private Properties
    private let navigator: HomeNavigator
    
    init(navigator: HomeNavigator) {
        self.navigator = navigator
        super.init(navigator: navigator)
    }
    
    // MARK: Public Function
    
    func presentSideMenu() {
        navigator.presentSideMenu()
    }
    
    func logout() {
        AuthManager.shared.token = nil
        UserManager.shared.removeUser()
        Application.shared.presentInitialScreen(in: appDelegate.window)
    }
    
    // MARK: Private Function
}
