//
//  JoinRoomResult.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import Foundation

enum JoinRoomError {
    case network
    case unknown
}

enum JoinRoomResult {
    case success
    case failure(_ error: JoinRoomError)
}
