//
//  UpdateVoteResult.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import Foundation

enum UpdateNominationsError {
    case network
    case unknown
}

enum UpdateNominationsResult {
    case success
    case failure(_ error: UpdateNominationsError)
}
