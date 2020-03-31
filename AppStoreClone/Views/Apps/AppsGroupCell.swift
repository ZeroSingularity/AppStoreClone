//
//  AppsGroupCell.swift
//  AppStoreClone
//
//  Created by Jacobo Hernandez on 3/26/20.
//  Copyright © 2020 Jacobo Hernandez. All rights reserved.
//

import UIKit

class AppsGroupCell: UICollectionViewCell {
    let titleLabel = UILabel(text: "App Section", font: .boldSystemFont(ofSize: 30))
    let horizontalController = AppsHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        addSubview(titleLabel)
        addSubview(horizontalController.view)
        horizontalController.view.backgroundColor = .gray
        
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 0))
        horizontalController.view.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
