//
//  iTunesNetworkCall.swift
//  MusicSearch_iTunesAPI
//
//  Created by Shak Feizi on 8/20/21.
//

import UIKit


class iTunesNetworkCall {
    // Shak notes: Properties
    static let sharedInstance: iTunesNetworkCall = iTunesNetworkCall()
    var artistsArray: [Song?] = []
    var artists: Song?
    
    // https://itunes.apple.com/search?term=musicArtist
    
    // Shak notes: Functions
    func fetchSongs(searchTerm: String, completion: @escaping(Result<[Song?], NetworkError>) -> Void) {
        guard let url = ResultsController.sharedInstance.buildURL(searchTerm: searchTerm) else { return }
        print(url)
        // URLSession
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Handling Error , Response and Data
            if let error = error {
                completion(.failure(.thrownError(error)))
            }
            if let response = response as? HTTPURLResponse {
                print("Response Status Code: \(response.statusCode)")
            }
            guard let data = data else { return completion(.failure(.noData)) }
            do {
                guard let resultTLO = try JSONDecoder().decode(Results?.self, from: data) else { return }
                print(resultTLO)
                completion(.success(resultTLO.results))
            } catch {
                completion(.failure(.thrownError(error)))
            }
        } .resume()
    }
}
