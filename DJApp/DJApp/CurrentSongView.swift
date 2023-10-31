//
//  CurrentSongView.swift
//  DJApp
//
//  Created by user206471 on 12/2/21.
//

import SwiftUI



struct CurrentSongView: View {
    @StateObject private var viewModel = CurrentSongViewModel()
    var hosting: Bool = true
    
    
    var body: some View {
        
        VStack {
            //            Spacer()
            HStack {
                SongListingView(song: viewModel.currentSong!)
                
                Spacer()
                if !hosting {
                    Button (action: {
                        
                    }) {
                        Image(systemName: viewModel.paused ? "play.circle.fill" : "pause.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(Color.black)
                    }
                }
//                else {
//                    Button (action: {
//
//                    }) {
//                        Image(systemName: "ellipsis.circle.fill")
//                            .resizable()
//                            .frame(width: 40, height: 40)
//                            .foregroundColor(Color.black)
//                    }
//                }
            }
            
            SongProgressView(progress: viewModel.timeElapsed, maxValue: viewModel.duration)
            //            Spacer()
        }
        .padding()
        .onAppear {
            if let artwork = viewModel.currentSong?.artwork {
                print(artwork)
            }
        }
    }
}

struct SongListingView: View {
    @StateObject private var viewModel = CurrentSongViewModel()
    var song: Song
    
    var body: some View {
        HStack {
            if let artwork = song.artwork {
                AsyncImage(url: URL(string: artwork)) { image in
                    image.resizable()
                        .frame(width: 40, height: 40)
                        .cornerRadius(4)
                    
                } placeholder: {
                    Rectangle()
                        .frame(width: 40, height: 40)
                        .cornerRadius(4)
                    
                }
                
                
            }
            VStack (alignment: .leading) {

                    Text("**\(song.title)**").lineLimit(1)
                         
                    Text("\(song.artist)").lineLimit(1)
                        

                    
            }
        }
        
//        Spacer()
        
        
        
    }
    
}

struct SongProgressView: View {
    var progress: Double
    var maxValue: Double
    
    var body: some View {
        
        
        ZStack {
            GeometryReader { geometry in
                
                Capsule()
                    .frame(width: geometry.size.width, height: 4)
                    .foregroundColor(Color.black)
                    .opacity(0.2)
                Capsule()
                    .frame(width: geometry.size.width * progress / maxValue, height: 4)
                    .foregroundColor(Color.black)
            }
            //            .frame(height: 4)
        }
        .frame(height: 4)
    }
}

struct CurrentSongView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentSongView()
    }
}
