//
//  NewPlaylistView.swift
//  DJApp
//
//  Created by user206471 on 3/8/22.
//

import SwiftUI

struct NewPlaylistView: View {
    @StateObject var viewModel = NewPlaylistViewModel()
    
    var addToQueue: Bool
    
    var body: some View {
      //  GeometryReader { geometry in
            VStack {
                Text(addToQueue ? "Queue Playlist" : "Change Current Playlist")
                    .font(Font.system(size: 30).bold())
                    .padding()
                  //  .frame(height: geometry.size.height * 0.1, alignment: .center)
                ScrollView {
                ForEach(1..<10) { k in
                    
                
                
                ForEach(Array(stride(from: 0, to: viewModel.playlists.count, by: 2)), id: \.self) { i in
                    
                    
                    HStack {
                      //  Spacer()
                        Button(action: {
                            
                        }) {
                            PlaylistView(playlist: viewModel.playlists[i])
                                
                        }
                        .padding()
                        .foregroundColor(Color.black)
                     //   .frame(width: 100, height: 50)
                //        Spacer()
                        Button(action: {
                            
                        }) {
                            PlaylistView(playlist: viewModel.playlists[i + 1])
                        }
                        .padding()
                        .foregroundColor(Color.black)
                //        .frame(width: 50, height: 50)
                 //       Spacer()
                    }
                    .padding()
                 //   Spacer()
                }
                }
                
                }
            }
        
      //  }
    }
}

struct NewPlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        NewPlaylistView(addToQueue: true)
    }
}

struct PlaylistView: View {
    var playlist: Playlist
    
    var body: some View {
        VStack {
            if let artwork = playlist.artwork {
                AsyncImage(url: URL(string: artwork)) { image in
                    image.resizable()
                    //                        .frame(width: 100, height: 100)
                        .cornerRadius(4)
                    
                } placeholder: {
                    
                    Rectangle()

                        .frame(width: 100, height: 100)
                        .cornerRadius(4)
                        .background(Color.clear)
                    
                }
            }
            Text(playlist.name)
        }
    }
}

