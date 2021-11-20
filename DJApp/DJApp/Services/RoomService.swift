//
//  RoomService.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import Foundation

protocol RoomService {
    var room: Room? { get }
    
    func joinRoom(_ code: String) async -> JoinRoomResult
    func refreshRoom() async -> RefreshRoomResult
    
    func hostRoom(_ name: String) async -> HostRoomResult
    
    func leaveRoom() async -> LeaveRoomResult
    
    func updateCurrentSong(song: Song) async -> UpdateSongResult
    func updateNominations(song1: Song, song2: Song) async -> UpdateNominationsResult

    func vote(vote: Vote) async -> VoteResult
    
    func subscribeToRoomUpdates(_ listener: RoomObserver)
    func unsubscribeFromRoomUpdates(_ listener: RoomObserver)
}
