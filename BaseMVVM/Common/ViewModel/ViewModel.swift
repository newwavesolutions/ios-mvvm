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

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}

class ViewModel : NSObject {
    let disposeBag = DisposeBag()
    
    private let _navigator: Navigator

    let loading = ActivityIndicator()
    let headerLoading = ActivityIndicator()
    let footerLoading = ActivityIndicator()
    
    init(navigator: Navigator) {
        self._navigator = navigator
        super.init()
    }
}
