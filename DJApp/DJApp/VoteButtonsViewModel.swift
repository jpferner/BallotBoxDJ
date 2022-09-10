//
//  VoteButtonsViewModel.swift
//  DJApp
//
//  Created by user206471 on 4/5/22.
//

import Foundation

class VoteButtonsViewModel: ObservableObject {
    @Published var roomService: RoomService
    @Published var room: Room?
    @Published var displayVotes: Bool = false
//    @Published private var nominations:(Song, Song)
//
//    @Published private var vote:Vote?
//
//    @Published private var voteTally: VoteTally
//
//    @Published var onVote:(Vote) ->()
    
    init() {
        self.roomService = ServiceLocator.roomService
        self.room = roomService.room
//        self.entry = roomService.room!.settings
        
    }
}
