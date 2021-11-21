//
//  RootViewModel.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import Foundation

class RootViewModel: ObservableObject {
    
    let roomService: RoomService
    
    @Published var room: Room? = nil
    
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
