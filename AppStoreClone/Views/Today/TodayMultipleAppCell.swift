//
//  TodayMultipleAppCell.swift
//  AppStoreClone
//
//  Created by Jacobo Hernandez on 4/15/20.
//  Copyright © 2020 Jacobo Hernandez. All rights reserved.
//

import UIKit

class TodayMultipleAppCell: BaseTodayCell {
    override var todayItem: TodayItem! {
        didSet {
            categoryLabel.text = todayItem.category
            titleLabel.text = todayItem.title
            multipleAppsController.results = todayItem.apps
            multipleAppsController.collectionView.reloadData()
        }
    }
    
    let categoryLabel = UILabel(text: "THE DAILY LIST", font: .boldSystemFont(ofSize: 20))
    let titleLabel = UILabel(text: "Utilizing your Time", font: .boldSystemFont(ofSize: 28), numberOfLines: 2)
    let multipleAppsController = TodayMultipleAppsController(mode: .small)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 16
        let stackView = VerticalStackView(arrangedSubviews: [
            categoryLabel, titleLabel, multipleAppsController.view
        ], spacing: 12)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
