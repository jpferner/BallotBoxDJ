//
//  LoadPlaylistResult.swift
//  DJApp
//
//  Created by Sam on 11/21/21.
//

import Foundation

enum LoadPlaylistError {
    case notFound
    case unauthorized
    case network
    case unknown
}

enum LoadPlaylistResult {
    case success(_ playlist: Playlist)
    case failure(_ error: LoadPlaylistError)
}
