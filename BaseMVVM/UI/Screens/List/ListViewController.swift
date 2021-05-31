//
//  ListViewController.swift
//  BaseMVVM
//
//  Created by Lê Thọ Sơn on 4/29/20.
//  Copyright © 2020 thoson.it. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ListViewController: ViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let refreshControl = UIRefreshControl()
    
    let headerRefreshTrigger = PublishSubject<Void>()
    let footerRefreshTrigger = PublishSubject<Void>()
    
    let isHeaderLoading = BehaviorRelay(value: false)
    let isFooterLoading = BehaviorRelay(value: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func makeUI() {
        super.makeUI()
        
        tableView.register(nibWithCellClass: ItemTableViewCell.self)
        tableView.tableFooterView = UIView()
        tableView.refreshControl = refreshControl
        isHeaderLoading.subscribe(onNext: { [weak self] (isLoading) in
            guard let self = self else { return }
            if isLoading {
                self.refreshControl.beginRefreshing()
            } else {
                self.refreshControl.endRefreshing()
            }
        }).disposed(by: disposeBag)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = self.viewModel as? ListViewModel else { return }
        
        let itemSelected = tableView.rx.modelSelected(ItemCellViewModel.self).asDriver()
        
        let refresh = Observable.of(Observable.just(()), headerRefreshTrigger).merge()
        let input = ListViewModel.Input(headerRefresh: refresh,
                                         footerRefresh: footerRefreshTrigger,
                                         selection: itemSelected)
        let output = viewModel.transform(input: input)
        
        viewModel.loading.asObservable().bind(to: isLoading).disposed(by: disposeBag)
        viewModel.headerLoading.asObservable().bind(to: isHeaderLoading).disposed(by: disposeBag)
        viewModel.footerLoading.asObservable().bind(to: isFooterLoading).disposed(by: disposeBag)
        
        output.items.asDriver(onErrorJustReturn: [])
            .drive(self.tableView.rx.items(cellIdentifier: ItemTableViewCell.className, cellType: ItemTableViewCell.self)) { tableView, viewModel, cell in
                cell.bind(viewModel: viewModel)
        }.disposed(by: self.disposeBag)
        
        refreshControl.rx.controlEvent(.valueChanged).bind { [weak self] _ in
            guard let self = self else { return }
            self.headerRefreshTrigger.onNext(())
        }.disposed(by: disposeBag)
        
        tableView.rx.prefetchRows.subscribe(onNext: {[weak self] indexPaths in
            guard let self = self else { return }
            let count = output.items.value.count
            if indexPaths.contains(where: { (indexPath) -> Bool in
                return count == indexPath.row + 1
            }) {
                self.footerRefreshTrigger.onNext(())
            }
        }).disposed(by: disposeBag)
    }
    
}
