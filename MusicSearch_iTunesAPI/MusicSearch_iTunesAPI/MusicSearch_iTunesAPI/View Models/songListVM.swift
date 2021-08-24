//
//  ItemListVM.swift
//  MusicSearch_iTunesAPI
//
//  Created by Shak Feizi on 8/21/21.
//

import SwiftUI
import Combine


class SongVM: Identifiable, ObservableObject {
    let id: Int
    let artist: String
    let track: String
    let price: Double
    let releaseDate: String
    let genre: String
    @Published var artistImage: Image?

    init(song: Song) {
        self.id = song.artistId
        self.artist = song.artistName
        self.track = song.trackName
        self.price = song.trackPrice
        self.releaseDate = song.releaseDate
        self.genre = song.primaryGenreName
    }
}


class SongListVM: ObservableObject {
    // Shak notes: Properties
    static let sharedSongListVM: SongListVM = SongListVM()
    @Published var searchTerm: String = ""
    @Published var songsArray: [SongVM] = []
    @Published var isLoading = false
    private var resultController: ResultsController = ResultsController()
    private var song: Song?
    private var desposable = Set<AnyCancellable>()
    
    init() {
        $searchTerm
            .sink(receiveValue: fetchDataForView(searchTerms:))
            .store(in: &desposable)
    }
    
    // Shak notes: Funtions
    func fetchDataForView(searchTerms: String?) {
        //songsArray.removeAll()
        isLoading = true
        //self.resultController.reset()
        guard let searchTerm = searchTerms else { return }
        iTunesNetworkCall.sharedInstance.fetchSongs(searchTerm: searchTerm) { results in
            switch results {
            case .success(let songs):
                DispatchQueue.main.async {
                    songs.forEach { self.appendSong(song: $0) }
                    print(self.songsArray)
                    self.isLoading = false
                }
            case .failure(let error):
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
        }
    }
    
    func appendSong(song: Song?) {
        //isLoading = true
        guard let song = song else { return }
        let songVM = SongVM(song: song)
        DispatchQueue.main.async {
            self.songsArray.append(songVM)
            //self.isLoading = false
        }
        resultController.fetchImage(song: song) { image in
            DispatchQueue.main.async {
                songVM.artistImage = image
            }
        }
    }
    
}
