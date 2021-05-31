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

class ListViewModel: ViewModel, ViewModelType {
    struct Input {
        let headerRefresh: Observable<Void>
        let footerRefresh: Observable<Void>
        let selection: Driver<ItemCellViewModel>
    }
    
    struct Output {
        let items: BehaviorRelay<[ItemCellViewModel]>
    }
    
    let navigator: ListNavigator
    
    private var page = 1
    
    private let movies = BehaviorRelay<[Item]>(value: [])
    
    init(navigator: ListNavigator) {
        self.navigator = navigator
        super.init(navigator: navigator)
    }
    
    func transform(input: Input) -> Output {
        //Input
        input.headerRefresh.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.page = 1
            self.fetchItems(at: self.page)
        }).disposed(by: disposeBag)
        
        input.footerRefresh.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.fetchItems(at: self.page + 1)
        }).disposed(by: disposeBag)
        
        input.selection.drive(onNext: {[weak self] cellVM in
            self?.navigator.pushDetail(data: cellVM.item)
        }).disposed(by: disposeBag)
        
        //Output
        let elements = BehaviorRelay<[ItemCellViewModel]>(value: [])
        movies.map { movies -> [ItemCellViewModel] in
            return movies.map { movie -> ItemCellViewModel in
                return ItemCellViewModel(item: movie)
            }
        }.bind(to: elements).disposed(by: disposeBag)
        return Output(
            items: elements
        )
    }
    
    private func fetchItems(at page: Int) {
        Application.shared.apiProvider.getItems(page: page, pageSize: 20)
            .trackActivity(page == 1 ? headerLoading : footerLoading)
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
