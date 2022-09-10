//
//  SongLinkViewModel.swift
//  DJApp
//
//  Created by user206471 on 12/20/21.
//

import Foundation

class SongLinkViewModel: ObservableObject {
    let roomService: RoomService
    @Published var room: Room?
    
    @Published var playedSongs: [Song]
    
    
    
    
    init(roomService: RoomService) {
        self.roomService = roomService
        self.room = roomService.room
        
        self.playedSongs = [roomService.room!.nominations!.0, roomService.room!.nominations!.1]
    }
}
