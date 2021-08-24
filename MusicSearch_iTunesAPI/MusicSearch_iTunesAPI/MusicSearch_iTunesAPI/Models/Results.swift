//
//  Response.swift
//  MusicSearch_iTunesAPI
//
//  Created by Shak Feizi on 8/20/21.
//

import UIKit


struct Results: Codable {
    let results: [Song?]
}

struct Song: Codable {
    let artistId: Int
    let artistName: String
    let trackName: String
    let trackPrice: Double
    let releaseDate: String
    let primaryGenreName: String
    let artistViewUrl: String
}
