//
//  RoomServiceImpl.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import Foundation

class RoomServiceImpl: RoomService {
    
    let roomRepository: RoomRepository
    
    private var _room: Room? = nil {
        didSet {
            sendRoomChangedNotification()
        }
    }
    
    var room: Room? {
        get { _room }
    }
    
    init() {
        roomRepository = MockRoomRepository()
    }
    
    func joinRoom(_ code: String) async -> JoinRoomResult {
        return .success
    }
    
    func refreshRoom() async -> RefreshRoomResult {
        return .success
    }
    
    func hostRoom(_ name: String) async -> HostRoomResult {
        let result = await roomRepository.hostRoom(name)
        
        switch (result) {
        case .success(let room):
            self._room = room
        case .failure:
            break
        }
        
        return result
    }
    
    func leaveRoom() async -> LeaveRoomResult {
        await Task.sleep(UInt64(Double(NSEC_PER_SEC)))
        
        self._room = nil
        
        return .success
    }
    
    func updateCurrentSong(song: Song) async -> UpdateSongResult {
        return .success
    }
    
    func updateNominations(song1: Song, song2: Song) async -> UpdateNominationsResult {
        return .success
    }
    
    func vote(vote: Vote) async -> VoteResult {
        return .success
    }
    
    private func sendRoomChangedNotification() {
        NotificationCenter.default.post(name: .roomChanged, object: self)
    }
    
}
