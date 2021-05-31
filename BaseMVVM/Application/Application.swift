//
//  Application.swift
//  BaseMVVM
//
//  Created by Lê Thọ Sơn on 4/20/20.
//  Copyright © 2020 thoson.it. All rights reserved.
//

import UIKit

final class Application: NSObject {
    static let shared = Application()

    var window: UIWindow?

    var apiProvider: ApiProvider
    var mockProvider: ApiProvider
    
    private override init() {
        apiProvider = ApiProvider()
        mockProvider = ApiProvider(mockData: true)
        super.init()
    }

    func presentInitialScreen(in window: UIWindow?) {
        guard let window = window else { return }
        self.window = window
        guard let viewController = UIStoryboard.main?.instantiateViewController(withClass: SplashViewController.self) else {
            return
        }
        let navigator = SplashNavigator(with: viewController)
        let viewModel = SplashViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft, animations: {
            window.rootViewController = UINavigationController(rootViewController: viewController)
        }, completion: nil)
    }
}
