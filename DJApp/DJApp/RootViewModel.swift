//
//  RootViewModel.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import SwiftUI
import Foundation

class RootViewModel: ObservableObject {
    
    let roomService: RoomService
    
    @Published var room: Room? = nil
    
    @Published var colors = [Color(hex: "#327846"), Color(hex: "#97a2dd"), Color(hex: "#8400ff"), Color(hex: "#e8657f"), Color(hex: "#ff8f43")]
    
    init() {
        roomService = ServiceLocator.roomService
        
        NotificationCenter.default.addObserver(forName: .roomChanged, object: nil, queue: .main) { _ in
            self.room = self.roomService.room
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
