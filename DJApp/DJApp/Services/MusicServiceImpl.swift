//
//  MusicServiceImpl.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import Foundation
import Alamofire

enum SpotifyConnectionError {
    case unknown
}

enum SpotifyConnectionResult {
    case success
    case failure(_ error: SpotifyConnectionError)
}

class SpotifyAPI: NSObject, SPTAppRemoteDelegate, SPTAppRemotePlayerStateDelegate, SPTSessionManagerDelegate {
    
    let spotifyClientID = "b5b5eb5fe785416f85a3a0129518b8bc"
    let spotifyRedirectURL = URL(string: "djapp-spotify://spotify-login-callback")!
    
    lazy var configuration: SPTConfiguration = {
        let configuration = SPTConfiguration(clientID: spotifyClientID, redirectURL: spotifyRedirectURL)
        
//        configuration.playURI = ""
        
        configuration.tokenSwapURL = URL(string: "https://warm-citadel-50889.herokuapp.com/swap")
        configuration.tokenRefreshURL = URL(string: "https://warm-citadel-50889.herokuapp.com/refresh")
        
        return configuration
    }()
    
    lazy var sessionManager: SPTSessionManager = {
        let manager = SPTSessionManager(configuration: self.configuration, delegate: self)
        return manager
    }()
    
    lazy var appRemote: SPTAppRemote = {
        let appRemote = SPTAppRemote(configuration: self.configuration, logLevel: .debug)
        appRemote.delegate = self
        return appRemote
    }()
    
    var accessToken: String?
    
    var connectionContinuations: [CheckedContinuation<SpotifyConnectionResult, Never>] = []
    
    var connected: Bool {
        get {
            return sessionManager.session != nil
        }
    }
    
    func connect() async -> SpotifyConnectionResult {
        return await withCheckedContinuation() { continuation in
            DispatchQueue.main.async {
                self.connectionContinuations.append(continuation)
                let scope: SPTScope = [.appRemoteControl, .playlistReadPrivate]
                self.sessionManager.initiateSession(with: scope, options: .clientOnly)
            }
        }
    }
    
    func handleOpenURL(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) {
        print("handling url")
        
        sessionManager.application(app, open: url, options: options)
    }
    
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        print("Spotify session initiated")
        print("Spotify access token: \(session.accessToken)")
        
        DispatchQueue.main.async {
            for continuation in self.connectionContinuations {
                continuation.resume(returning: .success)
            }
            self.connectionContinuations.removeAll()
            
            self.appRemote.connectionParameters.accessToken = session.accessToken
            self.appRemote.connect()
        }
    }
    
    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        print("Spotify session renewed")
    }
    
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        DispatchQueue.main.async {
            for continuation in self.connectionContinuations {
                continuation.resume(returning: .failure(.unknown))
            }
            self.connectionContinuations.removeAll()
        }
        
        print("Spotify session failed")
    }
    
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        self.appRemote.playerAPI?.delegate = self
        self.appRemote.playerAPI?.pause(nil)
        
        print("Spotify remote established connection")
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        print("Spotify remote disconnected")
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        print("Spotify remote failed to connect")
    }
    
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
        print("Player state updated")
    }
    
    func loadPlaylists() async -> LoadPlaylistsResult {
        return await withCheckedContinuation({ continuation in
            let url = "https://api.spotify.com/v1/me/playlists"
            
            let headers: HTTPHeaders = [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(self.sessionManager.session?.accessToken ?? "")"
            ]
            
            AF.request(url, method: .get, headers: headers).responseJSON { response in
                switch response.result {
                case .success(let data):
                    let json = data as! [String: Any]
                    let items = json["items"] as! [[String: Any]]
                    let playlists = items.map { item -> Playlist in
                        let id = item["id"] as! String
                        let name = item["name"] as! String
                        return Playlist(id: id, name: name)
                    }
                    continuation.resume(returning: .success(playlists))
                case .failure(let error):
                    continuation.resume(returning: .failure(.unknown))
                }
            }
        })
    }
    
    func loadPlaylist(_ playlistId: String) async -> LoadPlaylistResult {
        return await withCheckedContinuation({ continuation in
            let url = "https://api.spotify.com/v1/playlists/\(playlistId)"
            
            let headers: HTTPHeaders = [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(self.sessionManager.session?.accessToken ?? "")"
            ]
            
            AF.request(url, method: .get, headers: headers).responseJSON { response in
                switch response.result {
                case .success(let data):
                    let json = data as! [String: Any]
                    let playlist = Playlist(
                        id: json["id"] as! String,
                        name: json["name"] as! String
                    )
                    continuation.resume(returning: .success(playlist))
                case .failure(let error):
                    continuation.resume(returning: .failure(.unknown))
                }
            }
        })
    }
    
    func playPlaylist(_ playlistId: String) {
        appRemote.playerAPI?.play("spotify:playlist:\(playlistId)");
    }
    
}

class MusicServiceImpl: MusicService {
    
    private var _provider: Provider? {
        didSet {
            sendProviderUpdatedNotification()
        }
    }
    
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
    
    private var _currentSong: Song? {
        didSet {
            sendCurrentSongChangedNotification()
        }
    }
    
    private var _currentSongStatus: SongStatus? {
        didSet {
            sendCurrentSongStatusUpdatedNotification()
        }
    }
    
    var provider: Provider? {
        get { _provider }
    }
    
    var currentPlaylist: Playlist? {
        get { _currentPlaylist }
    }
    
    var songs: [Song] {
        get { _songs }
    }
    
    var currentSong: Song? {
        get { _currentSong }
    }
    
    var currentSongStatus: SongStatus? {
        get { _currentSongStatus }
    }
    
    func chooseProvider(provider: Provider) async -> ChooseProviderResult {
        if provider == .spotify {
            if !ServiceLocator.spotifyAPI.connected {
                let result = await ServiceLocator.spotifyAPI.connect()
                
                switch (result) {
                case .success:
                    break
                case .failure(let error):
                    return .failure(.unknown)
                }
            }
        }
        
        _provider = provider
        _currentPlaylist = nil
        resetSongs()
        
        return .success
    }
    
    func loadPlaylists() async -> LoadPlaylistsResult {
        if let provider = _provider {
            switch provider {
            case .apple:
                return .success([])
            case .spotify:
                return await ServiceLocator.spotifyAPI.loadPlaylists()
            }
        } else {
            return .failure(.noProvider)
        }
    }
    
    func selectPlaylist(_ playlistId: String?) async -> SelectPlaylistResult {
        if let playlistId = playlistId {
            if let provider = _provider {
                switch provider {
                case .apple:
                    return .failure(.noProvider)
                case .spotify:
                    let result = await ServiceLocator.spotifyAPI.loadPlaylist(playlistId)
                    
                    switch result {
                    case .success(let playlist):
                        self._currentPlaylist = playlist
                    case .failure(let error):
                        switch error {
                        case .notFound:
                            return .failure(.notFound)
                        case .unauthorized:
                            return .failure(.noProvider)
                        case .network:
                            return .failure(.network)
                        case .unknown:
                            return .failure(.unknown)
                        }
                    }
                }
            } else {
                return .failure(.noProvider)
            }
        } else {
            self._currentPlaylist = nil
        }
        
        resetSongs()
        
        if let currentPlaylist = _currentPlaylist {
            ServiceLocator.spotifyAPI.playPlaylist(currentPlaylist.id)
        }
        
        return .success
    }
    
    func loadSongs() async -> LoadSongsResult {
        _songs = [
            Song(id: "song-1", provider: .spotify, title: "Song 1", artist: "Artist 1"),
            Song(id: "song-2", provider: .spotify, title: "Song 2", artist: "Artist 2"),
            Song(id: "song-3", provider: .spotify, title: "Song 3", artist: "Artist 3"),
            Song(id: "song-4", provider: .spotify, title: "Song 4", artist: "Artist 4"),
            Song(id: "song-5", provider: .spotify, title: "Song 5", artist: "Artist 5"),
        ]
        
        return .success
    }
    
    func playSong(song: Song) {
        _currentSong = song
        _currentSongStatus = SongStatus(timeElapsed: 0.0, duration: 180.0)
    }
    
    private func resetSongs() {
        _songs = []
        _currentSong = nil
        _currentSongStatus = nil
    }
    
    private func sendProviderUpdatedNotification() {
        NotificationCenter.default.post(name: .providerUpdated, object: self)
    }
    
    private func sendCurrentPlaylistChangedNotification() {
        NotificationCenter.default.post(name: .playlistSelected, object: self)
    }
    
    private func sendSongsUpdatedNotification() {
        NotificationCenter.default.post(name: .songsUpdated, object: self)
    }
    
    private func sendCurrentSongChangedNotification() {
        NotificationCenter.default.post(name: .currentSongChanged, object: self)
    }
    
    private func sendCurrentSongStatusUpdatedNotification() {
        NotificationCenter.default.post(name: .currentSongStatusUpdated, object: self)
    }
    
}
