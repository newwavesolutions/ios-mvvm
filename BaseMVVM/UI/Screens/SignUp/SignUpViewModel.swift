//
//  SignUpViewModel.swift
//  BaseMVVM
//
//  Created by Lê Thọ Sơn on 4/20/20.
//  Copyright © 2020 thoson.it. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SignUpViewModel: ViewModel {
    // MARK: Public Properties
    
    // MARK: Private Properties
    private let navigator: SignUpNavigator
    
    private let userName = BehaviorRelay(value: "")
    private let password = BehaviorRelay(value: "")
    
    init(navigator: SignUpNavigator) {
        self.navigator = navigator
        super.init(navigator: navigator)
    }
    
    // MARK: Public Function
    
    func changeUserName(userName: String) -> Void {
        self.userName.accept(userName)
    }
    
    func changePassword(password: String) -> Void {
        self.password.accept(password)
    }
    
    func signUp() {
        let userName = self.userName.value
        if userName.isEmpty {
            navigator.showAlert(title: "Common.Error".localized(),
                                message: "Login.Username.Empty".localized())
            return
        }
        let password = self.password.value
        if password.isEmpty {
            navigator.showAlert(title: "Common.Error".localized(),
                                message: "Login.Password.Empty".localized())
            return
        }
        
        Application.shared
            .mockProvider
            .login(username: userName, password: password)
            .trackActivity(loadingIndicator)
            .subscribe(onNext: { [weak self] token in
                guard let self = self else { return }
                //Save data
                AuthManager.shared.token = token
                self.fetchProfile()
            }, onError: {[weak self] error in
                self?.navigator.showAlert(title: "Common.Error".localized(),
                                          message: "Login.Username.Password.Invalid".localized())
            }).disposed(by: disposeBag)
    }
    
    // MARK: Private Function
    
    private func fetchProfile() {
        Application.shared
            .mockProvider
            .getProfile()
            .trackActivity(loadingIndicator)
            .subscribe(onNext: { [weak self] user in
                guard let self = self else { return }
                //Save data
                UserManager.shared.saveUser(user)
                //Navigate
                self.navigator.pushHome()
            }, onError: {[weak self] error in
                self?.navigator.showAlert(title: "Common.Error".localized(),
                                          message: "Login.Username.Password.Invalid".localized())
            }).disposed(by: disposeBag)
    }
}
