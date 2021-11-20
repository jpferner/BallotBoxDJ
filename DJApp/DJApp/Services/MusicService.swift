//
//  MusicService.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import Foundation

protocol MusicService {
    var currentPlaylist: Playlist? { get }
    
    func setPlaylist(_ playlistId: String?)
    
    func subscribeToPlaylistUpdates(_ listener: PlaylistObserver)
    func unsubscribeFromPlaylistUpdates(_ listener: PlaylistObserver)
    
}
