//
//  NetworkError.swift
//  MusicSearch_iTunesAPI
//
//  Created by Shak Feizi on 8/20/21.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        case .thrownError(let error):
            return "Error: \(error.localizedDescription) -> \(error)"
        case .invalidURL:
            return "Unable to reach the server."
        case .noData:
            return "The server responded with no data."
        case .unableToDecode:
            return "I'm a scrub"
        }
    }
}
