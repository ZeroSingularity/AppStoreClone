//
//  TodayItem.swift
//  AppStoreClone
//
//  Created by Jacobo Hernandez on 4/10/20.
//  Copyright © 2020 Jacobo Hernandez. All rights reserved.
//

import UIKit

struct TodayItem {
    let category: String,
        title: String,
        image: UIImage,
        description: String,
        backgroundColor: UIColor,
        cellType: CellType
    enum CellType: String {
        case single
        case multiple
    }
}
