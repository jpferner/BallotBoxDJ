//
//  HostRoomViewModel.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import Foundation

class HostRoomViewModel: ObservableObject {
    let roomService: RoomService
    
    @Published var roomName: String = ""
    
    @Published var loading: Bool = false
    @Published var errorMessage: String? = nil
    
    init() {
        roomService = ServiceLocator.roomService
    }
    
    func hostRoom() {
        self.loading = true
        
        Task.detached {
            let result = await self.roomService.hostRoom(self.roomName)
            
            switch (result) {
            case .success:
                break
            case .failure(let error):
                switch (error) {
                case .network:
                    self.errorMessage = "A network error occurred."
                case .unknown:
                    self.errorMessage = "An unknown error occurred."
                }
            }
            
            self.loading = false
        }
    }
    
}
