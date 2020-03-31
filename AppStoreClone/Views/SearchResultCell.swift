//
//  SearchResultCell.swift
//  AppStoreClone
//
//  Created by Jacobo Hernandez on 3/23/20.
//  Copyright © 2020 Jacobo Hernandez. All rights reserved.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    var appResult: Result! {
        didSet {
            nameLabel.text = appResult.trackName
            CategoryLabel.text = appResult.primaryGenreName
            ratingsLabel.text = "\(appResult.averageUserRating ?? 0)"
            appIconImageView.sd_setImage(with: URL(string: appResult.artworkUrl100))
            screenshot1ImageView.sd_setImage(with: URL(string: appResult.screenshotUrls[0]))
            if appResult.screenshotUrls.count > 1 {
                screenshot2ImageView.sd_setImage(with: URL(string: appResult.screenshotUrls[1]))
            }
            
            if appResult.screenshotUrls.count > 2 {
                screenshot3ImageView.sd_setImage(with: URL(string: appResult.screenshotUrls[2]))
            }
        }
    }
    
    let appIconImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "App Name"
        
        return label
    }()
    
    let CategoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos & Video"
        
        return label
    }()

    let ratingsLabel: UILabel = {
        let label = UILabel()
        label.text = "9.62M"
        
        return label
    }()
    
    let getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.layer.cornerRadius = 16
        
        return button
    }()
    
    lazy var screenshot1ImageView = self.createScreenshotImageView()
    lazy var screenshot2ImageView = self.createScreenshotImageView()
    lazy var screenshot3ImageView = self.createScreenshotImageView()
    
    private func createScreenshotImageView() -> UIImageView {
        let iv = UIImageView()
        iv.layer.cornerRadius = 8
        iv.clipsToBounds = true
        iv.layer.borderWidth = 0.5
        iv.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        iv.contentMode = .scaleAspectFill
        
        return iv
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
                
        let topInfoStackView = UIStackView(arrangedSubviews:
            [appIconImageView,
             VerticalStackView(arrangedSubviews: [nameLabel, CategoryLabel, ratingsLabel]),
             getButton])
        topInfoStackView.spacing = 12
        topInfoStackView.alignment = .center
        topInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let screenshotsStackView = UIStackView(arrangedSubviews:
            [screenshot1ImageView,
             screenshot2ImageView,
             screenshot3ImageView])
        screenshotsStackView.spacing = 12
        screenshotsStackView.distribution = .fillEqually
        
        let overallStackView = VerticalStackView(arrangedSubviews:
            [topInfoStackView,
             screenshotsStackView], spacing: 16)
        
        addSubview(overallStackView)
        
        overallStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        
        NSLayoutConstraint.activate([
//            overallStackView.topAnchor.constraint(equalTo: self.topAnchor),
//            overallStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
//            overallStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            overallStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            appIconImageView.widthAnchor.constraint(equalToConstant: 64),
            appIconImageView.heightAnchor.constraint(equalToConstant: 64),
            getButton.widthAnchor.constraint(equalToConstant: 80),
            getButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
