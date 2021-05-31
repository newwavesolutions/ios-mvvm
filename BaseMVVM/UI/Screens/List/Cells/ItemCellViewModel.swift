//
//  ItemCellViewModel.swift
//  BaseMVVM
//
//  Created by Lê Thọ Sơn on 4/29/20.
//  Copyright © 2020 thoson.it. All rights reserved.
//

import Foundation

class ItemCellViewModel: CellViewModel {
    let item: Item
    
    init(item: Item) {
        self.item = item
        super.init()
        self.title.accept(item.name)
        self.imageUrl.accept(item.thumbnail)
    }
}
