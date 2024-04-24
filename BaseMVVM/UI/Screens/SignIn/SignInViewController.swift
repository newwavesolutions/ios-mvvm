//
//  SignInViewController.swift
//  BaseMVVM
//
//  Created by Lê Thọ Sơn on 4/29/20.
//  Copyright © 2020 thoson.it. All rights reserved.
//

import UIKit

class SignInViewController: ViewController<SignInViewModel, SignInNavigator> {
    @IBOutlet weak private var loginButton: UIButton!
    @IBOutlet weak private var signUpButton: UIButton!
    @IBOutlet weak private var usernameTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        
    }
    
    override func setupUI() {
        super.setupUI()
        //        setTitle("Login", subTitle: nil)
        //        showBackButton()
        usernameTextField.text = "Son Le"
        passwordTextField.text = "123456"
    }
    
    override func setupListener() {
        super.setupListener()
        
        loginButton.rx.tap.bind {[weak self] text in
            guard let self = self else { return }
            self.viewModel.signIn(userName: usernameTextField.text ?? "",
                                  password: passwordTextField.text ?? "")
        }.disposed(by: disposeBag)
        
        signUpButton.rx.tap.bind {[weak self] text in
            guard let self = self else { return }
            self.viewModel.openSignUp()
        }.disposed(by: disposeBag)
        
        viewModel.loadingIndicator.asObservable().bind(to: isLoading).disposed(by: disposeBag)
    }
}
