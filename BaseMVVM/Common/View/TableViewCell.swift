//
//  TableViewCell.swift
//  BaseMVVM
//
//  Created by Lê Thọ Sơn on 1/4/20.
//  Copyright © 2020 thoson.it. All rights reserved.
//

import Foundation
import RxSwift

class TableViewCell: UITableViewCell {
    var disposeBag =  DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag =  DisposeBag()
    }
    
    func bind(viewModel: CellViewModel) {
        
    }
}
