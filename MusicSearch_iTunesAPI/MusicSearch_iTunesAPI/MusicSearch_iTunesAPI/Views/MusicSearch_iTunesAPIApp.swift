//
//  MusicSearch_iTunesAPIApp.swift
//  MusicSearch_iTunesAPI
//
//  Created by Shak Feizi on 8/20/21.
//

import SwiftUI

@main
struct MusicSearch_iTunesAPIApp: App {
    var body: some Scene {
        WindowGroup {
            SearchListView(songListVM: SongListVM())
        }
    }
}


