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

class ___VARIABLE_sceneName___CollectionViewCell: CollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func bind(viewModel: CellViewModel) {
        guard let viewModel = viewModel as? ___VARIABLE_sceneName___CellViewModel else {
            return
        }
    }
}
