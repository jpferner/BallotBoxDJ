//
//  RoomRepository.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import Foundation

protocol RoomRepository {
    
    func hostRoom(_ name: String) async -> HostRoomResult
    
    func joinRoom(_ code: String) async -> JoinRoomResult
    
    func vote(_ vote: Vote) async -> VoteResult
    
}
