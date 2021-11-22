//
//  LoadPlaylistsResult.swift
//  DJApp
//
//  Created by Sam on 11/21/21.
//

import Foundation

enum LoadPlaylistsError {
    case network
    case unknown
    case noProvider
}

enum LoadPlaylistsResult {
    case success(_ playlists: [Playlist])
    case failure(_ error: LoadPlaylistsError)
}
