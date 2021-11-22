//
//  PlaylistSelectionViewModel.swift
//  DJApp
//
//  Created by Sam on 11/21/21.
//

import Foundation

class PlaylistSelectionViewModel: ObservableObject {
    
    private let musicService: MusicService
    
    @Published var loading: Bool = false
    @Published var playlists: [Playlist] = []
    @Published var errorMessage: String? = nil
    
    init() {
        musicService = ServiceLocator.musicService
        
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
