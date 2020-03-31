//
//  AppsPageHeader.swift
//  AppStoreClone
//
//  Created by Jacobo Hernandez on 3/26/20.
//  Copyright © 2020 Jacobo Hernandez. All rights reserved.
//

import UIKit

class AppsPageHeader: UICollectionReusableView {
    let appHeaderHorizontalController = AppsHeaderHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        addSubview(appHeaderHorizontalController.view)
        appHeaderHorizontalController.view.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
