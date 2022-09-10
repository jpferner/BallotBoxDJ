//
//  JoinRoomView.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import SwiftUI
//import XCTest


struct JoinRoomView: View {
    enum NavigationItem {
        case manual
        case scan
        
    }
    @State private var showGuest: Bool = false
    @State private var navigationItem: NavigationItem? = nil
    var body: some View {
        VStack {
            NavigationLink(destination: EnterCodeView(), tag: .manual, selection: $navigationItem) {
                EmptyView()
                
            }
    //        NavigationLink(destination: GuestSectionView(roomService: MockRoomService()), tag: .scan, selection: $navigationItem) {
    //            EmptyView()
    //        }
            
            Text("Join a Room")
            VStack {
                Button(action: {
                    showGuest = true
                }) {
                    Text("Scan QR Code")
                }
                .foregroundColor(Color.black)
                       
                Button(action: {
                    self.navigationItem = .manual
                }) {
                    Text("Enter Code Manually")
                }
                .foregroundColor(Color.black)
                
                
            }
            
        
            .fullScreenCover(isPresented: $showGuest) {
    //            GuestSectionView(roomService: MockRoomService())
                        }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .modifier(BackgroundColorStyle())
        
    }
}

struct JoinRoomView_Previews: PreviewProvider {
    static var previews: some View {
        JoinRoomView()
    }
}
