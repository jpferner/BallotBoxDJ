//
//  Room.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import Foundation

struct Room {
    let id: String
    let name: String
    let code: String
    let hosting: Bool
    let currentSong: Song?
    let nominations: (Song, Song)?
    let vote: Vote?
}
