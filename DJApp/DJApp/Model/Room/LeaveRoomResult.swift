//
//  LeaveRoomResult.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import Foundation

enum LeaveRoomError {
    case network
    case unknown
}

enum LeaveRoomResult {
    case success
    case failure(_ error: LeaveRoomError)
}
