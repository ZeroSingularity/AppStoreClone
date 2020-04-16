//
//  MultipleAppCell.swift
//  AppStoreClone
//
//  Created by Jacobo Hernandez on 4/16/20.
//  Copyright © 2020 Jacobo Hernandez. All rights reserved.
//

import UIKit

class MultipleAppCell: UICollectionViewCell {
    var app: FeedResult! {
        didSet {
            nameLabel.text = app.name
            companyLabel.text = app.artistName
            imageView.sd_setImage(with: URL(string: app.artworkUrl100))
        }
    }
    
    let imageView = UIImageView(cornerRadius: 16)
    let nameLabel = UILabel(text: "App Name", font: .systemFont(ofSize: 20))
    let companyLabel = UILabel(text: "Company Name", font: .systemFont(ofSize: 13))
    let getButton = UIButton(title: "GET")
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.3, alpha: 0.3)
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.constrainWidth(constant: 64)
        imageView.constrainHeight(constant: 64)
        imageView.backgroundColor = .lightGray
        getButton.constrainWidth(constant: 80)
        getButton.constrainHeight(constant: 32)
        getButton.titleLabel?.font = .boldSystemFont(ofSize: 14)
        getButton.backgroundColor = UIColor(white: 0.95, alpha: 1)
        getButton.layer.cornerRadius = 16
        
        let stackView = UIStackView(arrangedSubviews:
            [imageView,
             VerticalStackView(arrangedSubviews: [nameLabel, companyLabel], spacing: 4),
             getButton])
        stackView.spacing = 16
        stackView.alignment = .center
        
        addSubview(stackView)
        addSubview(separatorView)
        stackView.fillSuperview()
        separatorView.anchor(top: nil, leading: nameLabel.leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: -8, right: 0) ,size: .init(width: 0, height: 0.5))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
