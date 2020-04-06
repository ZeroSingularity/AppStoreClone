//
//  ScreenshotCell.swift
//  AppStoreClone
//
//  Created by Jacobo Hernandez on 4/6/20.
//  Copyright © 2020 Jacobo Hernandez. All rights reserved.
//

import UIKit

class ScreenshotCell: UICollectionViewCell {
    let imageView = UIImageView(cornerRadius: 12)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        imageView.backgroundColor = .gray
        imageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
