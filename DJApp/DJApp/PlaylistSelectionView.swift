//
//  PlaylistSelectionView.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import SwiftUI

struct PlaylistSelectionView: View {
    @StateObject private var viewModel = PlaylistSelectionViewModel(roomService: MockRoomService())
    
    @State private var showPrompt = false
    @State private var removePlaylist = false
    @State private var removeSong: Int?
    
    
    @State private var nominationQueue: [Song]?
    
    @State private var skipPrompt = false
    @State private var playlistPrompt = false
    
    @State private var changePlaylist = false
    @State private var queuePlaylist = false
    
    var body: some View {
//        GeometryReader { geometry in
//
        NavigationView {
            
            
            
            VStack {
            
                if viewModel.loading {
                    ProgressView()
                }
                // } else if let errorMessage = viewModel.errorMessage {
                //     Text(errorMessage)
                // } else {
                //               List(viewModel.playlists, id: \.id) { playlist in
                //                 Text(playlist.name)
                
                //                   .onTapGesture {
                //                     viewModel.selectPlaylist(playlist.id)
                //         }
                //     }
                    
//                GeometryReader { geometry in
                
                Text("**Current Playlist**")
                    .font(Font.system(size: 30))
                    .padding()
                
                Spacer()
                
                NavigationLink(destination: NewPlaylistView(addToQueue: queuePlaylist), isActive: $changePlaylist) {
                    
                    
                    
                    
                    Button(action: {
                        playlistPrompt = true
                    }) {
                    PlaylistView(playlist: viewModel.playlists[0])
                  //      .foregroundColor(Color.clear)
                   //     .aspectRatio(contentMode: .fit)
                       // .scaledToFit()
                    }
               //     .frame(height: geometry.size.height * 0.2)
                }
                
                Spacer()
                
                List {
                    Section(header: Text("Nomination Queue")) {
                        ForEach(1..<15) { x in
                        ForEach(viewModel.nominationQueue.indices) { i in
                            
                            
                            Button(action: {
                                showPrompt = true
                                removeSong = i
                            }) {
                                
                                
                                SongListingView(song: viewModel.nominationQueue[i])
                                
                            }
                            .foregroundColor(Color.black)
                            
                            
                        }
                        }
                        
                    }

                    
                    Section(header: Text("Playlist Queue")) {
                        
                             
                         
                        
                        ForEach(viewModel.nominationQueue.indices) { i in
                            
                            
                            Button(action: {
                                removePlaylist = true
                                removeSong = i
                            }) {
           
                                SongListingView(song: viewModel.nominationQueue[i])
                                
                            }
                            .foregroundColor(Color.black)
                            

                            
                        }
                        
                                                    
                    }
                   
                  //  .padding()
                  //  .padding(.bottom)
                   // .scaledToFit()
                    
                } //list
                .frame(height: UIScreen.main.bounds.height * 0.7)
                
                .actionSheet(isPresented: $showPrompt) {
                    ActionSheet(title: Text("Remove this song from the nomination queue?"), buttons: [
                        .cancel(),
                        .default(Text("Remove"),
                                 action: { viewModel.nominationQueue.remove(at: removeSong!)
                                     
                                     self.nominationQueue = viewModel.nominationQueue
                                 }
                                )]
                    )
                    
                }
                
                .actionSheet(isPresented: $removePlaylist) {
                    ActionSheet(title: Text("Remove this playlist from the playlist queue?"), buttons: [
                        .cancel(),
                        .default(Text("Remove"),
                                 action: { viewModel.nominationQueue.remove(at: removeSong!)
                                     
                                     self.nominationQueue = viewModel.nominationQueue
                                 }
                                )]
                    )
                    
                }
                
//                .padding()
                .listStyle(.plain)
                //.scaledToFit()
              //  .frame(height: geometry.size.height * 0.8)
               // .aspectRatio(contentMode: .fit)
                
                Spacer()
                
                
                
                .padding(.bottom)
                
      //          .padding(.bottom)
//                Spacer()
            
                .actionSheet(isPresented: $playlistPrompt) {
                    
                    ActionSheet(title: Text("Playlist Options"), buttons: [
                        .cancel(),

                        
                            .default(Text("Change Current Playlist"), action: {
                                changePlaylist = true
                                queuePlaylist = false
                            }),
                            .default(Text("Queue Playlist"), action: {
                                changePlaylist = true
                                queuePlaylist = true }),
                        .default(Text("Skip Playlist"), action: {})]
                )}
            }
            Spacer()
            .padding(.bottom)

        //    .padding(.bottom)
        //    .background(Color(hex: "#8400ff"))
        
      //  .frame(alignment: .top)
        .actionSheet(isPresented: $skipPrompt) {
            ActionSheet(title: Text("Skip to the next playlist in queue?"), buttons: [
                .cancel(),
                .default(Text("Skip"),
                         action: {}
                         
            )]
        )
        }
        
            
    }
        
}

struct PlaylistSelectionView_Previews: PreviewProvider {
   static var previews: some View {
  PlaylistSelectionView()
  }
}

struct PlaylistView: View {
    var playlist: Playlist
    
    var body: some View {
        VStack {
            if let artwork = playlist.artwork {
                AsyncImage(url: URL(string: artwork)) { image in
                    image.resizable()
                        .frame(width: 200, height: 200)
                        .background(Color.black)
                    //                        .frame(width: 100, height: 100)
                        .cornerRadius(4)
                    
                } placeholder: {
                    
                    Rectangle()
                        .scaledToFit()
                        
                        .frame(width: 200, height: 200)
                      //  .frame(maxHeight: 200)
                        .cornerRadius(4)
                        .background(Color.black)
                        
                     //   .scaledToFit()
                        
                    
                }
                .frame(width: 00, height: 100, alignment: .center)
                
            }
            Text(playlist.name)
        }
    }
}
}

