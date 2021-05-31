//
//  CheckboxButton.swift
//  BaseMVVM
//
//  Created by Lê Thọ Sơn on 4/20/20.
//  Copyright © 2020 thoson.it. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class CheckboxButton: UIButton {
    let onChecked = BehaviorRelay<Bool>(value: false)
    var disposeBag: DisposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeUI()
    }
    
    private func makeUI() {
        onChecked.subscribe(onNext: { [weak self] isChecked in
            guard let self = self else { return }
            if isChecked {
                self.setImage(UIImage(named: "ic_checkbox_on"), for: .normal)
            } else {
                self.setImage(UIImage(named: "ic_checkbox_off"), for: .normal)
            }
        }).disposed(by: disposeBag)
        
        rx.tap.bind { [weak self] () in
            guard let self = self else { return }
            let isChecked = self.onChecked.value
            self.onChecked.accept(!isChecked)
        }.disposed(by: disposeBag)
    }
    
    deinit {
        disposeBag = DisposeBag()
    }
}
