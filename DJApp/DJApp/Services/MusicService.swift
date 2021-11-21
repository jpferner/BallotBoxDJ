//
//  MusicService.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import Foundation

extension Notification.Name {
    static let currentPlaylistChanged = Notification.Name("currentPlaylistChanged")
    static let songsUpdated = Notification.Name("songsUpdated")
}

protocol MusicService {
    var currentPlaylist: Playlist? { get }
    var songs: [Song] { get }
    
    func setPlaylist(_ playlistId: String?)
    
    func loadSongs() async -> LoadSongsResult
    
    
    
}
