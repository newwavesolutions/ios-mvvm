//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template by: ___FULLUSERNAME___
//

import UIKit
import RxSwift
import RxCocoa

class ___VARIABLE_sceneName___ViewController: ViewController {
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func makeUI() {
        super.makeUI()
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = self.viewModel as? ___VARIABLE_sceneName___ViewModel else { return }
        
        let input = ___VARIABLE_sceneName___ViewModel.Input()
        let output = viewModel.transform(input: input)
    }
}
