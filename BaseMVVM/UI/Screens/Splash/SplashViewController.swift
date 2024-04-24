//
//  ViewController.swift
//  BaseMVVM
//
//  Created by Lê Thọ Sơn on 1/4/20.
//  Copyright © 2020 thoson.it. All rights reserved.
//

import UIKit

class SplashViewController: ViewController<SplashViewModel, SplashNavigator> {
    
    override func viewDidLoad() {
        let navigator = SplashNavigator(with: self)
        viewModel = SplashViewModel(navigator: navigator)
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func setupUI() {
        super.setupUI()
        clearNavigationBackground()
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationController?.navigationItem.hidesBackButton = true
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    override func setupListener() {
        super.setupListener()
    }
}

