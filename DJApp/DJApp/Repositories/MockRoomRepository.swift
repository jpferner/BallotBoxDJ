//
//  MockRoomRepository.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import Foundation

class MockRoomRepository: RoomRepository {
    
    func hostRoom(_ name: String) async -> HostRoomResult {
        await Task.sleep(UInt64(Double(NSEC_PER_SEC)))
        return .success(Room(id: "room-1",
                             name: name,
                             code: "ABC-DEF",
                             hosting: true,
                             currentSong: nil,
                             nominations: nil,
                             vote: nil
                            ))
//        return .failure(.network)
    }
    
}
