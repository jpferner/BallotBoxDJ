//
//  HostRoomResult.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import Foundation

enum HostRoomError {
    case network
    case unknown
}

enum HostRoomResult {
    case success(_ room: Room)
    case failure(_ error: HostRoomError)
}
