//
//  TodayController.swift
//  AppStoreClone
//
//  Created by Jacobo Hernandez on 4/8/20.
//  Copyright © 2020 Jacobo Hernandez. All rights reserved.
//

import UIKit

class TodayController: BaseListController, UICollectionViewDelegateFlowLayout {
    fileprivate let cellId = "cellId"
    var startingFrame: CGRect?
    var appFullscreenController: AppFullscreenController!
    var topConstraint: NSLayoutConstraint!
    var leadingConstraint: NSLayoutConstraint!
    var widthConstraint: NSLayoutConstraint!
    var heightConstraint: NSLayoutConstraint!
    
    let items = [
        
        TodayItem.init(category: "LIFE HACK", title: "Utilizing your Time", image: #imageLiteral(resourceName: "garden"), description: "All the tools and apps you need to intelligently organize your life the right way.", backgroundColor: .white),
        TodayItem.init(category: "HOLIDAYS", title: "Travel on a Budget", image: #imageLiteral(resourceName: "holiday"), description: "Find out all you need to know on how to travel without packing everything!", backgroundColor: #colorLiteral(red: 0.9838578105, green: 0.9588007331, blue: 0.7274674177, alpha: 1)),

    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        collectionView.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.929469943, blue: 0.9293007255, alpha: 1)
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TodayCell
        cell.todayItem = items[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return .init(width: view.frame.width - 64, height: 450)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 32, left: 0, bottom: 32, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let appFullscreenController = AppFullscreenController()
        appFullscreenController.todayItem = items[indexPath.row]
        appFullscreenController.dismissHandler = {
            self.handleRemoveFullscreenView()
        }
        
        let fullscreenView = appFullscreenController.view!
        view.addSubview(fullscreenView)
        addChild(appFullscreenController)
        self.appFullscreenController = appFullscreenController
        self.collectionView.isUserInteractionEnabled = false
        
        fullscreenView.frame = .init(x: 0, y: 0, width: 100, height: 200)
        fullscreenView.layer.cornerRadius = 16
        
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        
        // absolute coordinates of cell
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        self.startingFrame = startingFrame
        
        fullscreenView.translatesAutoresizingMaskIntoConstraints = false
        topConstraint = fullscreenView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
        leadingConstraint = fullscreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
        widthConstraint = fullscreenView.widthAnchor.constraint(equalToConstant: startingFrame.width)
        heightConstraint = fullscreenView.heightAnchor.constraint(equalToConstant: startingFrame.height)
        
        NSLayoutConstraint.activate([ topConstraint, leadingConstraint, widthConstraint, heightConstraint ])
        self.view.layoutIfNeeded() // needs to be called before animation
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.topConstraint.constant = 0
            self.leadingConstraint.constant = 0
            self.widthConstraint.constant = self.view.frame.width
            self.heightConstraint.constant = self.view.frame.height
            self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height
            self.view.layoutIfNeeded() // starts animation
            
            guard let cell = self.appFullscreenController.tableView.cellForRow(at: [0, 0]) as? AppFullscreenHeaderCell else { return }
            cell.todayCell.topConstraint.constant = 48
            cell.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc func handleRemoveFullscreenView() {
        // access starting frame
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.appFullscreenController.tableView.scrollToRow(at: [0, 0], at: .top, animated: true)
            
            guard let startingFrame = self.startingFrame else { return }
            
            self.topConstraint.constant = startingFrame.origin.y
            self.leadingConstraint.constant = startingFrame.origin.x
            self.widthConstraint.constant = startingFrame.width
            self.heightConstraint.constant = startingFrame.height
            
            self.view.layoutIfNeeded()
            
            if let tabBarFrame = self.tabBarController?.tabBar.frame {
                self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height - tabBarFrame.height
            }
            
            guard let cell = self.appFullscreenController.tableView.cellForRow(at: [0, 0]) as? AppFullscreenHeaderCell else { return }
            cell.todayCell.topConstraint.constant = 24
            cell.layoutIfNeeded()
        }, completion: { _ in
            self.appFullscreenController.view?.removeFromSuperview()
            self.appFullscreenController.removeFromParent()
            self.collectionView.isUserInteractionEnabled = true
        })
    }
}
