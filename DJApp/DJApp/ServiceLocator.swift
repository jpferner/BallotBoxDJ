//
//  ServiceLocator.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import Foundation

class ServiceLocator {
    
    static let spotifyAPI: SpotifyAPI = SpotifyAPI()
    
    static let roomService: RoomService = RoomServiceImpl()
    static let musicService: MusicService = MusicServiceImpl()
    
}
