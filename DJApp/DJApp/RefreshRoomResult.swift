//
//  RefreshRoomResult.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import Foundation

enum RefreshRoomError {
    case network
    case unknown
}

enum RefreshRoomResult {
    case success
    case failure(_ error: RefreshRoomError)
}
