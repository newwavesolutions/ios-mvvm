//
//  BaseViewModel.swift
//  BaseMVVM
//
//  Created by Lê Thọ Sơn on 1/4/20.
//  Copyright © 2020 thoson.it. All rights reserved.
//

import RxSwift
import RxCocoa
import Foundation

class ViewModel : NSObject {
    let disposeBag = DisposeBag()
    
    private let _navigator: Navigator

    let loadingIndicator = ActivityIndicator()
    
    init(navigator: Navigator) {
        self._navigator = navigator
        super.init()
    }
}
