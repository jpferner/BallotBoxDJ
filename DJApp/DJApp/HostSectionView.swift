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
        
        VStack {
            if viewModel.leaving {
                ProgressView()
            } else {
                if let errorMessage = viewModel.leavingErrorMessage {
                    Text(errorMessage)
                        .padding()
                }
                
                Text("Name: \(viewModel.room.name)")
                    .padding()

                Text("Code: \(viewModel.room.code)")
                    .padding()
                
                Button(action: {
                    viewModel.leaveRoom()
                }) {
                    Text("Leave Room")
                }
            }
        }
        .sheet(isPresented: noPlaylist) {
            SelectMusicProviderView()
                .interactiveDismissDisabled()
        }
    }
}

struct HostingSectionView_Previews: PreviewProvider {
    static var previews: some View {
        HostSectionView()
    }
}
