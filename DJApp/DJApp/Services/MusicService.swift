//
//  MusicService.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import Foundation

extension Notification.Name {
    static let providerUpdated = Notification.Name("providerUpdated")
    static let playlistSelected = Notification.Name("playlistSelected")
    static let songsUpdated = Notification.Name("songsUpdated")
    static let currentSongChanged = Notification.Name("currentSongChanged")
    static let currentSongStatusUpdated = Notification.Name("currentSongStatusUpdated")
}

protocol MusicService {
    var provider: Provider? { get }
    
    var currentPlaylist: Playlist? { get }
    var songs: [Song] { get }
    var currentSong: Song? { get }
    var currentSongStatus: SongStatus? { get }
    
    func chooseProvider(provider: Provider) async -> ChooseProviderResult
    
    func loadPlaylists() async -> LoadPlaylistsResult
    
    func selectPlaylist(_ playlistId: String?) async -> SelectPlaylistResult
    
    func loadSongs() async -> LoadSongsResult
    
    func playSong(song: Song)
    
}
