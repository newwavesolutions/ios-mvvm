//
//  HomeViewController.swift
//  BaseMVVM
//
//  Created by Lê Thọ Sơn on 4/21/20.
//  Copyright © 2020 thoson.it. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: ViewController {
    @IBOutlet weak private var containerView: UIView!
    @IBOutlet weak var tab1Button: UIButton!
    @IBOutlet weak var tab2Button: UIButton!
    
    private lazy var tab1VC: ViewController = {
        let viewController = ListViewController(nibName: ListViewController.className, bundle: nil)
        let navigator = ListNavigator(with: viewController)
        let viewModel = ListViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        return viewController
    }()
    
    private lazy var tab2VC: ViewController = {
        let viewController = ListViewController(nibName: ListViewController.className, bundle: nil)
        let navigator = ListNavigator(with: viewController)
        let viewModel = ListViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        return viewController
    }()
    
    var currentViewController: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showTab1()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func makeUI() {
        super.makeUI()
        setTitle("MVVM DEMO",
                 subTitle: "Newwave solution CSJ")
        showLeftButton(image: UIImage(named: "ic_menu"))
        //Setup right button
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(self.rightButtonTapped(sender:)))
        navigationItem.rightBarButtonItem = barButtonItem
        //Setup tabs
        tab1Button.rx.tap.bind { [weak self] () in
            self?.showTab1()
        }.disposed(by: disposeBag)
        tab2Button.rx.tap.bind { [weak self] () in
            self?.showTab2()
        }.disposed(by: disposeBag)
    }

    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = self.viewModel as? HomeViewModel else { return }
        let menuAction = navigationItem.leftBarButtonItem!.rx.tap.asDriver()
        let logoutAction = navigationItem.rightBarButtonItem!.rx.tap.asDriver()
        let input = HomeViewModel.Input(menuAction: menuAction,
                                        logoutAction: logoutAction)
        let output = viewModel.transform(input: input)
    }
    
    //Show list data
    private func showTab1() {
        currentViewController?.removeViewAndControllerFromParentViewController()
        addChildViewController(tab1VC, toContainerView: containerView)
        currentViewController = tab1VC
    }
    
    private func showTab2() {
        currentViewController?.removeViewAndControllerFromParentViewController()
        addChildViewController(tab2VC, toContainerView: containerView)
        currentViewController = tab2VC
    }
}
