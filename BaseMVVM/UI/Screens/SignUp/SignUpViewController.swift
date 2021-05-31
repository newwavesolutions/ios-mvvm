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

class SignUpViewController: ViewController {
    @IBOutlet weak private var signUpButton: UIButton!
    @IBOutlet weak private var usernameTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func makeUI() {
        super.makeUI()
        setTitle("Navigation.Title".localized(), subTitle: "Newwave solution CSJ")
        showLeftButton()
        usernameTextField.text = "Lê Thọ Sơn"
        passwordTextField.text = "123456"
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = viewModel as? SignUpViewModel else { return }
        let signUpAction = signUpButton.rx.tap.asDriver()
        let username = usernameTextField.rx.text.orEmpty.asDriver()
        let password = passwordTextField.rx.text.orEmpty.asDriver()
        let input = SignUpViewModel.Input(userName: username,
                                          password: password,
                                          signUpAction: signUpAction)
        let output = viewModel.transform(input: input)
        viewModel.loading.asObservable().bind(to: isLoading).disposed(by: disposeBag)
    }
}
