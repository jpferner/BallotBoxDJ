//
//  SelectMusicProviderViewModel.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import Foundation

class SelectMusicProviderViewModel: ObservableObject {
    
    let roomService:RoomService
    let musicService: MusicService
    
    @Published var room: Room?
    
    init() {
        roomService = ServiceLocator.roomService
        musicService = ServiceLocator.musicService
        
        // todo remember this forced unwrap
        room = roomService.room
    }
    
    func pickApplePlaylist() {
        pickPlaylist()
    }
    
    func pickSpotifyPlaylist() {
        Task.detached {
            let result = await self.musicService.chooseProvider(provider: .spotify)
            
            switch result {
            case .success:
                print("successfully chose spotify provider")
            case .failure(_):
                print("failed to choose spotify provider")
            }
        }
    }
    
    func pickPlaylist() {
//        musicService.selectPlaylist("playlist-1")
    }
    
}
