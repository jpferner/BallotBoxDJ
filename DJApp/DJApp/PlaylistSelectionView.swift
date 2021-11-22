//
//  PlaylistSelectionView.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import SwiftUI

struct PlaylistSelectionView: View {
    @StateObject private var viewModel = PlaylistSelectionViewModel()
    
    var body: some View {
        VStack {
            if viewModel.loading {
                ProgressView()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            } else {
                List(viewModel.playlists, id: \.id) { playlist in
                    Text(playlist.name)
                        .onTapGesture {
                            viewModel.selectPlaylist(playlist.id)
                        }
                }
            }
        }
    }
}

struct PlaylistSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistSelectionView()
    }
}
