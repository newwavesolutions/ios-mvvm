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

class SignInViewModel: ViewModel, ViewModelType {
    struct Input {
        let userName: Driver<String>
        let password: Driver<String>
        let loginAction: Driver<Void>
        let signUpAction: Driver<Void>
    }
    
    struct Output {
        
    }
    
    private let userName = BehaviorRelay(value: "")
    private let password = BehaviorRelay(value: "")
    
    private let navigator: SignInNavigator
    
    init(navigator: SignInNavigator) {
        self.navigator = navigator
        super.init(navigator: navigator)
    }
    
    func transform(input: Input) -> Output {
        input.userName.asObservable().bind(to: userName).disposed(by: disposeBag)
        input.password.asObservable().bind(to: password).disposed(by: disposeBag)
        input.loginAction.drive(onNext: { [weak self] _ in
            self?.login()
        }).disposed(by: disposeBag)
        input.signUpAction.drive(onNext: { [weak self] _ in
            self?.navigator.pushSignUp()
        }).disposed(by: disposeBag)
        return Output()
    }
    
    private func login() {
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
        
        Application.shared.mockProvider.login(username: userName, password: password).trackActivity(loading).subscribe(onNext: { [weak self] token in
            guard let self = self else { return }
            //Save data
            AuthManager.shared.token = token
            self.fetchProfile()
            }, onError: {[weak self] error in
                self?.navigator.showAlert(title: "Common.Error".localized(),
                                          message: "Login.Username.Password.Invalid".localized())
        }).disposed(by: disposeBag)
    }
    
    private func fetchProfile() {
        Application.shared.mockProvider.getProfile().trackActivity(loading).subscribe(onNext: { [weak self] user in
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
