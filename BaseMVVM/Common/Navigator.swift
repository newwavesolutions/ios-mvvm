//
//  BaseRouter.swift
//  BaseMVVM
//
//  Created by Lê Thọ Sơn on 1/4/20.
//  Copyright © 2020 thoson.it. All rights reserved.
//

import Foundation
import RxSwift

class Navigator {
    let disposeBag = DisposeBag()
    
    weak var viewController: UIViewController?
    
    lazy var navigationController: UINavigationController? = {
        return self.viewController?.navigationController
    }()
    
    lazy var topViewController: UIViewController? = {
        return appDelegate.topViewController()
    }()
    
    init(with viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func showErrorAlert(){
        showAlert(title: "Error", message: "System error")
    }
    
    func showAlert(title: String?, message: String?, buttonTitles: [String]? = nil, highlightedButtonIndex: Int? = nil, completion: ((Int) -> Void)? = nil) {
        viewController?.showAlert(title: title,
                                  message: message,
                                  buttonTitles: buttonTitles,
                                  highlightedButtonIndex: highlightedButtonIndex,
                                  completion: completion)
    }
}
