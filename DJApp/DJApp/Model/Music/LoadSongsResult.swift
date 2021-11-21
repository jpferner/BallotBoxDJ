//
//  LoadSongsResult.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import Foundation

enum LoadSongsError {
    case network
    case unknown
}

enum LoadSongsResult {
    case success
    case failure(_ error: LoadSongsError)
}
