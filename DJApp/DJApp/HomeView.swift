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
    
    var colors = [Color(hex: "#327846"), Color(hex: "#97a2dd"), Color(hex: "#8400ff"), Color(hex: "#e8657f"), Color(hex: "#ff8f43")]
    
    
    @State private var navigationItem: NavigationItem? = nil
    @State private var showSettings = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        showSettings = true
                    }) {
                        Image(systemName: "questionmark.app")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, alignment: .center)
                            .foregroundColor(Color.black)
                    }
                }
               // .frame(alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 4)
                
                Spacer()
                //HostSectionView()

             //   VStack {
                    NavigationLink(destination: HostRoomView(),
                                   tag: .hostRoom,
                                   selection: $navigationItem) {
                        EmptyView()
                    }
                    Button(action: {
                        self.navigationItem = .hostRoom
                    }) {
                        Text("**Host a Room**")
                    }
                    .font(Font.system( size: 30))
//                    .foregroundColor(Color.black)
           //     }
                
                
             //   VStack {
                    NavigationLink(destination: JoinRoomView(),
                                   tag: .joinRoom,
                                   selection: $navigationItem) {
                        EmptyView()
                    }
                    .foregroundColor(Color.black)
                    
                    Button(action: {
                        self.navigationItem = .joinRoom
                    }) {
                        Text("**Join a Room**")
                    }
                    .font(Font.system( size: 30))
//                    .foregroundColor(Color.black)
             //   }
                Spacer()
                
            }
          //  .frame(alignment: .leading)
            
           // .modifier(BackgroundColorStyle())
            //.background(colors[2])
          //  .background(LinearGradient(colors: [Color(hex: "#327846"), colors[2], colors[3]], startPoint: .bottomLeading, endPoint: .topTrailing))
        }
       // .modifier(BackgroundColorStyle())
        
        
    }
        
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
