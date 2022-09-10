//
//  Vote.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import Foundation

enum Vote: Equatable {
    case song(_ song: Song)
    case random
}
