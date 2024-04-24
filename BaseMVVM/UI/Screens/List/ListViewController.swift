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

class ListViewController: ViewController<ListViewModel, ListNavigator> {
    @IBOutlet weak var tableView: UITableView!
    
    private let refreshControl = UIRefreshControl()
    
    private let isPullToRefreshing = BehaviorRelay(value: false)
    private let isLoadingNextPage = BehaviorRelay(value: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.reloadData()
    }
    
    override func setupUI() {
        super.setupUI()
        
        tableView.register(nibWithCellClass: ItemTableViewCell.self)
        tableView.tableFooterView = UIView()
        tableView.refreshControl = refreshControl
        isPullToRefreshing.subscribe(onNext: { [weak self] (isLoading) in
            guard let self = self else { return }
            if isLoading {
                self.refreshControl.beginRefreshing()
            } else {
                self.refreshControl.endRefreshing()
            }
        }).disposed(by: disposeBag)
    }
    
    override func setupListener() {
        super.setupListener()
        
        refreshControl.rx.controlEvent(.valueChanged).bind { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.reloadData()
        }.disposed(by: disposeBag)
        
        tableView.rx.prefetchRows.subscribe(onNext: {[weak self] indexPaths in
            guard let self = self else { return }
            let count = self.viewModel.cellVMs.value.count
            if indexPaths.contains(where: { (indexPath) -> Bool in
                return count == indexPath.row + 1
            }) {
                self.viewModel.loadMoreData()
            }
        }).disposed(by: disposeBag)
        
        viewModel.cellVMs.asDriver(onErrorJustReturn: [])
            .drive(self.tableView.rx.items(cellIdentifier: ItemTableViewCell.className, cellType: ItemTableViewCell.self)) { tableView, viewModel, cell in
                cell.bind(viewModel: viewModel)
            }.disposed(by: self.disposeBag)
        
        tableView.rx.modelSelected(ItemCellViewModel.self).bind { [weak self] cellVM in
            guard let self = self else { return }
            self.viewModel.handleItemTapped(cellVM: cellVM)
        }.disposed(by: disposeBag)
        
        viewModel.loadingIndicator.asObservable().bind(to: isLoading).disposed(by: disposeBag)
    }
    
}
