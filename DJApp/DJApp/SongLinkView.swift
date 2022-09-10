//
//  SongLinkView.swift
//  DJApp
//
//  Created by user206471 on 12/20/21.
//

import SwiftUI

struct SongLinkView: View {
//    var roomService: RoomService
    
    @StateObject private var viewModel = SongLinkViewModel(roomService: MockRoomService())
    @State private var showLink = false
    @State private var link: Song?
    
    
    var body: some View {
        
        var songs = [viewModel.room!.currentSong!,
                     viewModel.room!.nominations!.0,
                     viewModel.room!.nominations!.1]
        VStack {
        Text("Song Links")
                .font(Font.system(size: 30).bold())
                .padding()
        List {
            Section(header: Text("Nominations")) {
                Button(action: {
                    showLink = true
                    link = viewModel.room!.nominations!.0
                }) {
                    SongListingView(song: viewModel.room!.nominations!.0)
                        .foregroundColor(Color.black)
                }
                Button(action: {
                    showLink = true
                    link = viewModel.room!.nominations!.1
                    
                }) {
                    SongListingView(song: viewModel.room!.nominations!.1)
                        .foregroundColor(Color.black)
                }
            }
            Section(header: Text("Current Song")) {
                Button(action: {
                    showLink = true
                    link = viewModel.room!.currentSong!
                    
                }) {
                    SongListingView(song: viewModel.room!.currentSong!)
                        .foregroundColor(Color.black)
                }
            }
            Section(header: Text("Played Songs")) {
                ForEach(viewModel.playedSongs, id: \.id) { song in
                    Button(action: {
                        showLink = true
                        link = song
                    }) {
                        SongListingView(song: song)
                            .foregroundColor(Color.black)
                    }
                }
            }
        }
        .listStyle(.plain)
        .actionSheet(isPresented: $showLink) {
            ActionSheet(title: Text("Open song in: "), buttons: [
                .cancel(),
                .default(
                    Text("Spotify"),
                    action: {}
                ),
                .default(
                    Text("Apple Music"),
                    action: {}
                )]
            )
        }
        }
        //            .environment(\.defaultMinListRowHeight, 100)
        
        
    }

}

struct SongLinkView_Previews: PreviewProvider {
    static var previews: some View {
        SongLinkView()
    }
}
