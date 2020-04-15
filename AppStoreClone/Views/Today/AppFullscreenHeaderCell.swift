//
//  AppFullscreenHeaderCell.swift
//  AppStoreClone
//
//  Created by Jacobo Hernandez on 4/10/20.
//  Copyright © 2020 Jacobo Hernandez. All rights reserved.
//

import UIKit

class AppFullscreenHeaderCell: UITableViewCell {
    let todayCell = TodayCell()
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(todayCell)
        addSubview(closeButton)
        todayCell.fillSuperview()
        closeButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 44, left: 0, bottom: 0, right: 12), size: .init(width: 80, height: 38))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
