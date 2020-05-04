//
//  AppsCompositionalView.swift
//  AppStoreClone
//
//  Created by Jacobo Hernandez on 4/23/20.
//  Copyright © 2020 Jacobo Hernandez. All rights reserved.
//

import SwiftUI

class CompositionalController: UICollectionViewController {
    fileprivate let headerId = "headerId"
    fileprivate let cellId = "cellId"
    fileprivate let appGroupCellId = "appGroupCellId"
    var socialApps = [SocialApp]()
    var games: AppGroup?
    var topGrossingApps: AppGroup?
    var freeApps: AppGroup?
    
    init() {
        let layout = UICollectionViewCompositionalLayout { (sectionNumber, _) -> NSCollectionLayoutSection? in
            if sectionNumber == 0 {
                return CompositionalController.topSection()
            } else {
                let item = NSCollectionLayoutItem.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/3)))
                item.contentInsets = .init(top: 0, leading: 0, bottom: 16, trailing: 16)
                let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize.init(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(300)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                let kind = UICollectionView.elementKindSectionHeader
                section.contentInsets.leading = 16
                section.orthogonalScrollingBehavior = .groupPaging
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: kind, alignment: .topLeading)
                ]
                return section
            }
        }
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class CompositionalHeader: UICollectionReusableView {
        let label = UILabel(text: "Editor's Choice Games", font: .boldSystemFont(ofSize: 32))
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            addSubview(label)
            label.fillSuperview()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemBackground
        navigationItem.title = "Apps"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        collectionView.register(CompositionalHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.register(AppsHeaderCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: appGroupCellId)
        
        fetchAppsDispatchGroup()
    }
    
    static func topSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets.bottom = 16
        item.contentInsets.trailing = 16
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(300)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.leading = 16
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    func fetchAppsDispatchGroup() {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        APIService.shared.fetchNewGames { (appGroup, err) in
            self.games = appGroup
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        APIService.shared.fetchTopGrossing { (appGroup, err) in
            self.topGrossingApps = appGroup
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        APIService.shared.fetchAppGroup(urlString: "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/25/explicit.json") { (appGroup, err) in
            self.freeApps = appGroup
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        APIService.shared.fetchSocialApps { (apps, err) in
            dispatchGroup.leave()
            self.socialApps = apps ?? []
        }
        
        // completion
        dispatchGroup.notify(queue: .main) {
            print("The collection view has been reloaded")
            self.collectionView.reloadData()
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return socialApps.count
        } else if section == 1 {
            return games?.feed.results.count ?? 0
        } else if section == 2{
            return topGrossingApps?.feed.results.count ?? 0
        } else {
            return freeApps?.feed.results.count ?? 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! CompositionalHeader
        var title: String?
        if indexPath.section == 1 {
            title = games?.feed.title
        } else if indexPath.section == 2 {
            title = topGrossingApps?.feed.title
        } else {
            title = freeApps?.feed.title
        }
        header.label.text = title
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsHeaderCell
            print(cell)
            cell.app = self.socialApps[indexPath.item]
            return cell
        default:
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: appGroupCellId, for: indexPath) as! AppRowCell
            var appGroup: AppGroup?
            if indexPath.section == 1 {
                appGroup = games
            } else if indexPath.section == 2 {
                appGroup = topGrossingApps
            } else {
                appGroup = freeApps
            }
            cell.app = appGroup?.feed.results[indexPath.item]
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let appId: String
        if indexPath.section == 0 {
            appId = socialApps[indexPath.item].id
        } else if indexPath.section == 1 {
            appId = games?.feed.results[indexPath.item].id ?? ""
        } else if indexPath.section == 2 {
            appId = topGrossingApps?.feed.results[indexPath.item].id ?? ""
        } else {
            appId = freeApps?.feed.results[indexPath.item].id ?? ""
        }
        let appDetailController = AppDetailController(appId: appId)
        navigationController?.pushViewController(appDetailController, animated: true)
    }
}

struct AppsView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = CompositionalController()
        return UINavigationController(rootViewController: controller)
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = UIViewController
}

struct AppsCompositionalView_Previews: PreviewProvider {
    static var previews: some View {
        AppsView()
            .edgesIgnoringSafeArea(.all)
    }
}
