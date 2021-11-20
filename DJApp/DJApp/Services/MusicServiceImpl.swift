//
//  MusicServiceImpl.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import Foundation

class MusicServiceImpl: MusicService {
    
    private var listeners: [PlaylistObserver] = []
    
    var currentPlaylist: Playlist? = nil
    
    func setPlaylist(_ playlistId: String?) {
        if let playlistId = playlistId {
            updatePlaylist(Playlist(id: playlistId, name: "Playlist"))
        } else {
            updatePlaylist(nil)
        }
    }
    
    private func updatePlaylist(_ playlist: Playlist?) {
        self.currentPlaylist = playlist
        for listener in listeners {
            listener.onChanged(playlist)
        }
    }
    
    func subscribeToPlaylistUpdates(_ listener: PlaylistObserver) {
        listeners.append(listener)
    }
    
    func unsubscribeFromPlaylistUpdates(_ listener: PlaylistObserver) {
        if let index = listeners.firstIndex(where: { $0 === listener }) {
            listeners.remove(at: index)
        }
    }
    
}
