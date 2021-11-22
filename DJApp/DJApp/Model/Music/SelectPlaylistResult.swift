//
//  SelectPlaylistResult.swift
//  DJApp
//
//  Created by Sam on 11/21/21.
//

import Foundation

enum SelectPlaylistError {
    case notFound
    case network
    case unknown
    case noProvider
}

enum SelectPlaylistResult {
    case success
    case failure(_ error: SelectPlaylistError)
}
