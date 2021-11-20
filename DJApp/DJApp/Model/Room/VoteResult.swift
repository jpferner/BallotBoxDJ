//
//  VoteResult.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import Foundation

enum VoteError {
    case network
    case unknown
}

enum VoteResult {
    case success
    case failure(_ error: VoteError)
}
