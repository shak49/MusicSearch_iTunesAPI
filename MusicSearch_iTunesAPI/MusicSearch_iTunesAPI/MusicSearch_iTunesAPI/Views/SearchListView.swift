//
//  ContentView.swift
//  MusicSearch_iTunesAPI
//
//  Created by Shak Feizi on 8/20/21.
//

import SwiftUI
import UIKit


struct SearchListView: View {
    // Shak notes: Properties
    @ObservedObject var songListVM: SongListVM
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    SearchBar(searchText: $songListVM.searchTerm)
                }
                .padding()
                if songListVM.songsArray.isEmpty {
                    EmptyStateView()
                } else if songListVM.isLoading {
                    LoadingView()
                } else {
                    List(songListVM.songsArray) { song in
                        SongView(songVM: song)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationBarTitle("Music Search")
        }
    }
}

struct SongView: View {
    // Shak notes: Properties
    @ObservedObject var songVM: SongVM
    var body: some View {
        HStack {
            ImageView(image: songVM.artistImage)
                .padding(.trailing)
            VStack(alignment: .leading) {
                Text(songVM.track)
                    .font(.system(size: 17))
                Spacer()
                HStack {
                    Text(songVM.artist)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Spacer()
                    Text(songVM.genre)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                //Spacer()
                HStack {
                    Text(songVM.releaseDate.prefix(7))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Spacer()
                    Text("$ \(songVM.price)".prefix(6))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding()
    }
}

struct ImageView: View {
    let image: Image?
    var body: some View {
        ZStack {
            if image != nil {
                image
            } else {
                Color(.systemBlue)
                Image(systemName: "music.note")
                    .font(.largeTitle)
                    .opacity(0.85)
                    .foregroundColor(.white)
            }
        }
        .frame(width: 75, height: 75)
        .shadow(radius: 5)
        .padding(.trailing, 1)
    }
}

struct EmptyStateView: View {
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "music.note.list")
                .font(.system(size: 85))
                .padding(.bottom)
            Text("Start searching for music...")
                .font(.title)
            Spacer()
        }
        .padding()
        .foregroundColor(Color(.systemBlue))
    }
}

struct SearchBar: UIViewRepresentable {
    typealias UIViewType = UISearchBar
    @Binding var searchText: String
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Enter an artist name..."
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {

    }
    
    func makeCoordinator() -> SearchBarCoordinator {
        return SearchBarCoordinator(searchTerm: $searchText)
    }
    
    class SearchBarCoordinator: NSObject, UISearchBarDelegate {
        @Binding var searchTerm: String
        
        init(searchTerm: Binding<String>) {
            self._searchTerm = searchTerm
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchTerm = searchBar.text ?? ""
            // Dismiss keyboard
            UIApplication.shared.windows.first { $0.isKeyWindow }?.endEditing(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchListView(songListVM: SongListVM())
    }
}
