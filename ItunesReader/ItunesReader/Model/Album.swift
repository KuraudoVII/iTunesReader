//
//  Album.swift
//  ItunesReader
//
//  Created by Licheng Zheng on 2020/2/7.
//  Copyright © 2020 Licheng Zheng. All rights reserved.
//

import UIKit

struct Album: Codable {
    let feed: feed
}

struct feed: Codable {
    let results: [results]?
}

struct results: Codable {
    let artistName: String
    let releaseDate: String
    let name: String
    let copyright: String
    let artworkUrl100: String
    let genres: [genres]?
    let url: URL
}

struct genres: Codable {
    let name: String
}
