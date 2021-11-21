//
//  HostSectionViewModel.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import Foundation

class HostSectionViewModel: ObservableObject {
    
    let roomService: RoomService
    let musicService: MusicService
    
    @Published var room: Room
    @Published var playlist: Playlist?
    
    @Published var leaving = false
    @Published var leavingErrorMessage: String? = nil
    
    init() {
        self.roomService = ServiceLocator.roomService
        self.room = roomService.room!
        
        self.musicService = ServiceLocator.musicService
        
        NotificationCenter.default.addObserver(forName: .currentPlaylistChanged, object: nil, queue: .main) { _ in
            self.playlist = self.musicService.currentPlaylist
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func onChanged(_ playlist: Playlist?) {
        self.playlist = playlist
    }
    
    func leaveRoom() {
        leaving = true
        
        Task.detached {
            let result = await self.roomService.leaveRoom()
            
            switch (result) {
            case .success:
                break;
            case .failure(let error):
                switch (error) {
                case .network:
                    self.leavingErrorMessage = "A network error occurred."
                case .unknown:
                    self.leavingErrorMessage = "An unknown error occurred."
                }
                self.leaving = false
            }
        }
    }
    
}
