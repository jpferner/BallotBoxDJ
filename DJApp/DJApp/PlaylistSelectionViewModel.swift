//
//  PlaylistSelectionViewModel.swift
//  DJApp
//
//  Created by Sam on 11/21/21.
//

import Foundation

class PlaylistSelectionViewModel: ObservableObject {
    
    private let musicService: MusicService
    
    private let roomService: RoomService
    @Published var room: Room?
    
    @Published var nominationQueue: [Song]
    
    @Published var loading: Bool = false
    @Published var playlists: [Playlist] = [Playlist(id: "playlist1", name: "The Playlist", artwork: ""), Playlist(id: "playlist 2", name: "Another Playlist", artwork: "")]
    @Published var errorMessage: String? = nil
    
    init(roomService: RoomService) {
        musicService = ServiceLocator.musicService
        
        self.roomService = roomService
        self.room = roomService.room
        
        self.nominationQueue = [roomService.room!.nominations!.0, roomService.room!.nominations!.1]
        
        loadPlaylists()
    }
    
    func loadPlaylists() {
        self.loading = true
        
        Task.detached {
            let result = await self.musicService.loadPlaylists()
            
            DispatchQueue.main.async {
                switch result {
                case .success(let playlists):
                    self.loading = false
                    self.errorMessage = nil
                    self.playlists = playlists
                case .failure(let error):
                    self.loading = false
                    self.errorMessage = "Error"
                }
            }
        }
    }
    
    func selectPlaylist(_ playlistId: String) {
        Task.detached {
            await self.musicService.selectPlaylist(playlistId)
        }
    }
    
}
