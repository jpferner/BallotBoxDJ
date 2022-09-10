//
//  File.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import Foundation

struct Song: Equatable {
    let id: String
    let provider: Provider
    let title: String
    let artist: String
    var artwork: String? = nil
}
