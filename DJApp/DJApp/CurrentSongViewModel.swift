//
//  CurrentSongViewModel.swift
//  DJApp
//
//  Created by user206471 on 12/2/21.
//

import SwiftUI

class CurrentSongViewModel: ObservableObject {
    @Published var currentSong: Song? = Song(id: "454", provider: .spotify, title: "Every Little Thing she Does is Magic", artist: "The Police", artwork: "https://upload.wikimedia.org/wikipedia/en/thumb/c/c3/Everylittlething.jpg/220px-Everylittlething.jpg")
    @Published var timeElapsed: Double = 120
    @Published var duration: Double = 180
    @Published var paused: Bool = false
    
    
    
}
