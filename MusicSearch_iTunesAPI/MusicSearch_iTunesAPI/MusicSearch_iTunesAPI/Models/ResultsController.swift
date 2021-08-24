//
//  ModelController.swift
//  MusicSearch_iTunesAPI
//
//  Created by Shak Feizi on 8/22/21.
//

import UIKit
import SwiftUI


class ResultsController {
    // https://itunes.apple.com/search?term=musicArtist
    
    // Shak notes: Properties
    static let sharedInstance: ResultsController = ResultsController()
    var dataTasks: [URLSessionDataTask] = []
    var url = URLComponents(string: "https://itunes.apple.com/search")
    
    init(url: URLComponents = URLComponents(string: "https://itunes.apple.com/search")!) {
        self.url = url
    }
    
    // Shak notes: Funtions
    func buildURL(searchTerm: String) -> URL? {
        guard !searchTerm.isEmpty else { return nil }
            var baseURL = url
            let query = [
                URLQueryItem(name: "term", value: searchTerm),
                URLQueryItem(name: "entity", value: "song")
            ]
            baseURL?.queryItems = query
            let finalURL = baseURL
            return finalURL?.url
    }
    
    func fetchImage(song: Song?, completion: @escaping((Image?) -> Void)) {
        guard let image = song?.artistViewUrl else { return }
        let imageURL = URL(string: image)
        completion(nil)
        let dataTask = URLSession.shared.dataTask(with: imageURL!) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else { return }
            let profileImage = Image(uiImage: image)
            completion(profileImage)
        }
        dataTasks.append(dataTask)
        dataTask.resume()
    }
    
    func reset() {
        dataTasks.forEach { $0.cancel() }
    }
}
