//
//  SignInViewModel.swift
//  BaseMVVM
//
//  Created by Lê Thọ Sơn on 4/29/20.
//  Copyright © 2020 thoson.it. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class SignInViewModel: ViewModel {
    // MARK: Public Properties
    
    // MARK: Private Properties
    private let navigator: SignInNavigator
    
    init(navigator: SignInNavigator) {
        self.navigator = navigator
        super.init(navigator: navigator)
    }
    
    // MARK: Public Function
    func signIn(userName: String, password: String) {
        if userName.isEmpty {
            navigator.showAlert(title: "Common.Error".localized(),
                                message: "Login.Username.Empty".localized())
            return
        }
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
    
    func openSignUp() {
        navigator.pushSignUp()
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
