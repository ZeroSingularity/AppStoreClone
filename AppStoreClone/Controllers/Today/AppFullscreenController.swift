//
//  AppFullscreenController.swift
//  AppStoreClone
//
//  Created by Jacobo Hernandez on 4/9/20.
//  Copyright © 2020 Jacobo Hernandez. All rights reserved.
//

import UIKit

class AppFullscreenController: UITableViewController {
    var dismissHandler: (() -> ())?
    var todayItem: TodayItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.contentInsetAdjustmentBehavior = .never
        let statusBar = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        tableView.contentInset = .init(top: 0, left: 0, bottom: statusBar.height, right: 0)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    @objc fileprivate func handleDismiss(button: UIButton) {
        button.isHidden = true
        dismissHandler?()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.item == 0 {
            let headeCell = AppFullscreenHeaderCell()
            headeCell.closeButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
            headeCell.todayCell.todayItem = todayItem
            headeCell.todayCell.layer.cornerRadius = 0
            headeCell.clipsToBounds = true
            return headeCell
        }
        
        let cell = AppFullscreenDescriptionCell()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return TodayController.cellSize
        }
        
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let cell = TodayCell()
//
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 450
//    }
}
