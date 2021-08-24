//
//  DateFormatter.swift
//  MusicSearch_iTunesAPI
//
//  Created by Shak Feizi on 8/23/21.
//

import UIKit

extension Date {
    func dateFormatter() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
}
