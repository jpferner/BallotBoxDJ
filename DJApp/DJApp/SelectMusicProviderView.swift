//
//  SelectMusicProviderView.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import SwiftUI

struct SelectMusicProviderView: View {
    @StateObject var viewModel = SelectMusicProviderViewModel()
    
    var body: some View {
        VStack {
            Text("Select Music App")
                .padding()
            
            Text("Name: \(viewModel.room?.name ?? "")")
                .padding()

            Text("Code: \(viewModel.room?.code ?? "")")
                .padding()
            
            Button(action: {
                viewModel.pickPlaylist()
            }) {
                Text("Apple Music")
                    .padding()
            }
            
            Button(action: {
                viewModel.pickPlaylist()
            }) {
                Text("Spotify")
                    .padding()
            }
        }
    }
}

struct SelectMusicProviderView_Previews: PreviewProvider {
    static var previews: some View {
        SelectMusicProviderView()
    }
}
