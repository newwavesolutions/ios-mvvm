//
//  ItemTableViewCell.swift
//  BaseMVVM
//
//  Created by Lê Thọ Sơn on 4/29/20.
//  Copyright © 2020 thoson.it. All rights reserved.
//

import UIKit

class ItemTableViewCell: TableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func bind(viewModel: CellViewModel) {
        guard let viewModel = viewModel as? ItemCellViewModel else {
            return
        }
        let item = viewModel.item
        viewModel.title.bind(to: titleLabel.rx.text).disposed(by: disposeBag)
        viewModel.imageUrl.map({ (string) -> URL? in
            return URL(string: string ?? "")
        }).bind(to: avatarImageView.rx.imageURL).disposed(by: disposeBag)
    }
}
