//
//  AppGroup.swift
//  AppStoreClone
//
//  Created by Jacobo Hernandez on 3/30/20.
//  Copyright © 2020 Jacobo Hernandez. All rights reserved.
//

import Foundation

struct AppGroup: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let title: String,
        results: [FeedResult]
}

struct FeedResult: Decodable {
    let name: String,
        artistName: String,
        artworkUrl100: String
}
