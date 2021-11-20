//
//  SelectMusicProviderViewModel.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import Foundation

class SelectMusicProviderViewModel: ObservableObject {
    
    let roomService: RoomService
    let musicService: MusicService
    
    @Published var room: Room
    
    init() {
        roomService = ServiceLocator.roomService
        musicService = ServiceLocator.musicService
        
        // todo remember this forced unwrap
        room = roomService.room!
    }
    
    func pickPlaylist() {
        musicService.setPlaylist("playlist-1")
    }
    
}
