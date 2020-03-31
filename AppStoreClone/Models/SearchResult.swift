//
//  SearchResult.swift
//  AppStoreClone
//
//  Created by Jacobo Hernandez on 3/24/20.
//  Copyright © 2020 Jacobo Hernandez. All rights reserved.
//

import Foundation

struct SearchResult: Decodable {
    let resultCount: Int,
        results: [Result]
}

struct Result: Decodable {
    let trackName: String,
        primaryGenreName: String,
        averageUserRating: Float?,
        screenshotUrls: [String],
        artworkUrl100: String
}
