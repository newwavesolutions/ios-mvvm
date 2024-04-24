//
//  ListViewModel.swift
//  BaseMVVM
//
//  Created by Lê Thọ Sơn on 4/29/20.
//  Copyright © 2020 thoson.it. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class ListViewModel: ViewModel {
    
    // MARK: Public Properties
    let cellVMs = BehaviorRelay<[ItemCellViewModel]>(value: [])
    
    // MARK: Private Properties
    private let navigator: ListNavigator
    private let movies = BehaviorRelay<[Item]>(value: [])
    private var page = 1
    
    init(navigator: ListNavigator) {
        self.navigator = navigator
        super.init(navigator: navigator)
        
        // Setup listener
        movies.map { movies -> [ItemCellViewModel] in
            return movies.map { movie -> ItemCellViewModel in
                return ItemCellViewModel(item: movie)
            }
        }.bind(to: cellVMs).disposed(by: disposeBag)
    }
    
    // MARK: Public Function
    
    func reloadData() {
        page = 1
        fetchItems(at: self.page)
    }
    
    func loadMoreData() {
        fetchItems(at: self.page + 1)
    }
    
    func handleItemTapped(cellVM: ItemCellViewModel) {
        navigator.pushDetail(data: cellVM.item)
    }
    
    // MARK: Private Function
    
    private func fetchItems(at page: Int) {
        Application.shared.apiProvider.getItems(page: page, pageSize: 20)
            .trackActivity(page == 1 ? loadingIndicator : ActivityIndicator())
            .subscribe(
                onNext: { [weak self] response in
                    guard let self = self else { return }
                    if response.results.isEmpty && page != 1 {
                        return
                    }
                    self.page = page
                    if page == 1 {
                        self.movies.accept(response.results)
                    } else {
                        self.movies.accept(self.movies.value + response.results)
                    }
                }, onError: { [weak self] error in
                    self?.navigator.showAlert(title: "Error",
                                              message: error.localizedDescription)
            }).disposed(by: disposeBag)
    }
}
