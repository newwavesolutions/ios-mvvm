//
//  SignInViewController.swift
//  BaseMVVM
//
//  Created by Lê Thọ Sơn on 4/29/20.
//  Copyright © 2020 thoson.it. All rights reserved.
//

import UIKit

class SignInViewController: ViewController {
    @IBOutlet weak private var loginButton: UIButton!
    @IBOutlet weak private var signUpButton: UIButton!
    @IBOutlet weak private var usernameTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        
    }
    
    override func makeUI() {
        super.makeUI()
//        setTitle("Login", subTitle: nil)
//        showBackButton()
        usernameTextField.text = "Lê Thọ Sơn"
        passwordTextField.text = "123456"
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = viewModel as? SignInViewModel else { return }
        let loginAction = loginButton.rx.tap.asDriver()
        let signUpAction = signUpButton.rx.tap.asDriver()
        let username = usernameTextField.rx.text.orEmpty.asDriver()
        let password = passwordTextField.rx.text.orEmpty.asDriver()
        let input = SignInViewModel.Input(userName: username,
                                          password: password,
                                          loginAction: loginAction,
                                          signUpAction: signUpAction)
        let output = viewModel.transform(input: input)
        viewModel.loading.asObservable().bind(to: isLoading).disposed(by: disposeBag)
    }
}
