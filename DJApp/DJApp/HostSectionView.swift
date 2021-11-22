//
//  HostingSectionView.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import SwiftUI

struct HostSectionView: View {
    @StateObject var viewModel = HostSectionViewModel()
    
    var body: some View {
        let noPlaylist = Binding<Bool>(get: { viewModel.playlist == nil }, set: { _ in })
        
        GeometryReader { geometry in
            VStack(alignment: .center) {
                if viewModel.leaving {
                    ProgressView()
                } else {
                    if let errorMessage = viewModel.leavingErrorMessage {
                        Text(errorMessage)
                            .padding()
                    }
                    
                    Text("Name: \(viewModel.room?.name ?? "")")
                        .padding()

                    Text("Code: \(viewModel.room?.code ?? "")")
                        .padding()
                    
                    Text("Playlist: \(viewModel.playlist?.name ?? "")")
                        .padding()
                    
                    Button(action: {
                        viewModel.leaveRoom()
                    }) {
                        Text("Leave Room")
                    }
                }
            }
            .frame(width: geometry.size.width)
        }
        .background(Color.green)
        .sheet(isPresented: noPlaylist) {
            PickPlaylistFlowView(provider: $viewModel.provider)
                .interactiveDismissDisabled()
        }
    }
}

struct PickPlaylistFlowView: View {
    @Binding var provider: Provider?
    
    var body: some View {
        if provider == nil {
            SelectMusicProviderView()
        } else {
            PlaylistSelectionView()
        }
    }
}

struct HostingSectionView_Previews: PreviewProvider {
    static var previews: some View {
        HostSectionView()
    }
}
