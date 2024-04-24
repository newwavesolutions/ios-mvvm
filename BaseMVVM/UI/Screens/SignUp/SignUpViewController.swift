//
//  SignUpViewController.swift
//  BaseMVVM
//
//  Created by Lê Thọ Sơn on 4/20/20.
//  Copyright © 2020 thoson.it. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpViewController: ViewController<SignUpViewModel, SignUpNavigator> {
    @IBOutlet weak private var signUpButton: UIButton!
    @IBOutlet weak private var usernameTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupUI() {
        super.setupUI()
        setTitle("Navigation.Title".localized(), subTitle: "Newwave solution CSJ")
        showLeftButton()
        usernameTextField.text = "Lê Thọ Sơn"
        passwordTextField.text = "123456"
    }
    
    override func setupListener() {
        super.setupListener()
        
        usernameTextField.rx.text.orEmpty.bind { [weak self] text in
            guard let self = self else { return }
            self.viewModel.changeUserName(userName: text)
        }.disposed(by: disposeBag)
        
        passwordTextField.rx.text.orEmpty.bind { [weak self] text in
            guard let self = self else { return }
            self.viewModel.changeUserName(userName: text)
        }.disposed(by: disposeBag)
        
        signUpButton.rx.tap.bind { [weak self] text in
            guard let self = self else { return }
            self.viewModel.signUp()
        }.disposed(by: disposeBag)
        
        viewModel.loadingIndicator.asObservable().bind(to: isLoading).disposed(by: disposeBag)
    }
}
