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

class HomeViewModel: ViewModel, ViewModelType {
    struct Input {
        let menuAction: Driver<Void>
        let logoutAction: Driver<Void>
    }
    struct Output {
        
    }
    
    private let navigator: HomeNavigator
    
    init(navigator: HomeNavigator) {
        self.navigator = navigator
        super.init(navigator: navigator)
    }
    
    func transform(input: Input) -> Output {
        input.menuAction.drive(onNext: { [weak self] _ in
            self?.navigator.presentSideMenu()
        }).disposed(by: disposeBag)
        input.logoutAction.drive(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.logout()
            Application.shared.presentInitialScreen(in: appDelegate.window)
        }).disposed(by: disposeBag)
        return Output()
    }
    
    private func logout() {
        AuthManager.shared.token = nil
        UserManager.shared.removeUser()
    }
}
