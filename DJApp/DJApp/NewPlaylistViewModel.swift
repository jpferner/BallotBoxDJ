//
//  NewPlaylistViewModel.swift
//  DJApp
//
//  Created by user206471 on 3/9/22.
//

import Foundation

class NewPlaylistViewModel: ObservableObject {
    @Published var playlists: [Playlist] = [Playlist(id: "playlist1", name: "The Playlist", artwork: ""), Playlist(id: "playlist 2", name: "Another Playlist", artwork: ""), Playlist(id: "playlist1", name: "The Playlist", artwork: ""), Playlist(id: "playlist 2", name: "Another Playlist", artwork: ""), Playlist(id: "playlist1", name: "The Playlist", artwork: ""), Playlist(id: "playlist 2", name: "Another Playlist", artwork: "")]
}
