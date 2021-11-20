//
//  ContentView.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import SwiftUI

struct HomeView: View {
    enum NavigationItem {
        case hostRoom
        case joinRoom
    }
    
    @State private var navigationItem: NavigationItem? = nil
    
    var body: some View {
        NavigationView {
            VStack(spacing: 48) {
                Text("Hello, world!")
                
                VStack {
                    NavigationLink(destination: HostRoomView(),
                                   tag: .hostRoom,
                                   selection: $navigationItem) {
                        EmptyView()
                    }
                    Button(action: {
                        self.navigationItem = .hostRoom
                    }) {
                        Text("Host a Room")
                    }
                }
                
                VStack {
                    NavigationLink(destination: JoinRoomView(),
                                   tag: .joinRoom,
                                   selection: $navigationItem) {
                        EmptyView()
                    }
                    Button(action: {
                        self.navigationItem = .joinRoom
                    }) {
                        Text("Join a Room")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
