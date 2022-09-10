//
//  HostRoom.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import SwiftUI

struct HostRoomView: View {
    @StateObject var viewModel = HostRoomViewModel()
    
    var body: some View {
        VStack {
            if viewModel.loading {
                ProgressView()
            } else {
                if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                }
                
                TextField("", text: $viewModel.roomName)
                
                Button(action: {
                    viewModel.hostRoom()
                }) {
                    Text("**Host Room**")
                }
                
            }
        }
        .modifier(BackgroundColorStyle())
    }
}

struct HostRoomView_Previews: PreviewProvider {
    static var previews: some View {
        HostRoomView()
    }
}
