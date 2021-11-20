//
//  UpdateSongResult.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import Foundation

enum UpdateSongError {
    case network
    case unknown
}

enum UpdateSongResult {
    case success
    case failure(_ error: UpdateSongError)
}
