//
//  RootViewModel.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import Foundation

class RootViewModel: ObservableObject, RoomObserver {
    
    let roomService: RoomService
    
    @Published var room: Room? = nil
    
    init() {
        roomService = ServiceLocator.roomService
        roomService.subscribeToRoomUpdates(self)
    }
    
    deinit {
        roomService.unsubscribeFromRoomUpdates(self)
    }
    
    func onChanged(_ room: Room?) {
        self.room = room
    }
    
}
