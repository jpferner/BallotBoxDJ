//
//  MusicServiceImpl.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import Foundation

class MusicServiceImpl: MusicService {
    
    private var _currentPlaylist: Playlist? {
        didSet {
            sendCurrentPlaylistChangedNotification()
        }
    }
    
    private var _songs: [Song] = [] {
        didSet {
            sendSongsUpdatedNotification()
        }
    }
    
    var currentPlaylist: Playlist? {
        get { _currentPlaylist }
    }
    
    var songs: [Song] {
        get { _songs }
    }
    
    func setPlaylist(_ playlistId: String?) {
        if let playlistId = playlistId {
            self._currentPlaylist = Playlist(id: playlistId, name: "Playlist")
        } else {
            self._currentPlaylist = nil
        }
    }
    
    func loadSongs() async -> LoadSongsResult {
        _songs = [
            Song(id: "song-1", title: "Song 1", artist: "Artist 1"),
            Song(id: "song-2", title: "Song 2", artist: "Artist 2"),
            Song(id: "song-3", title: "Song 3", artist: "Artist 3"),
            Song(id: "song-4", title: "Song 4", artist: "Artist 4"),
            Song(id: "song-5", title: "Song 5", artist: "Artist 5"),
        ]
        
        return .success
    }
    
    private func sendCurrentPlaylistChangedNotification() {
        NotificationCenter.default.post(name: .currentPlaylistChanged, object: self)
    }
    
    private func sendSongsUpdatedNotification() {
        NotificationCenter.default.post(name: .songsUpdated, object: self)
    }
    
}
