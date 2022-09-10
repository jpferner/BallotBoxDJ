//
//  GuestSectionViewModel.swift
//  DJApp
//
//  Created by user206471 on 11/23/21.
//

import SwiftUI
import Foundation

class GuestSectionViewModel: ObservableObject {
    
    let roomService: RoomService
    
    @Published var room: Room?
    
    @Published var leaving = false
    @Published var leavingErrorMessage: String? = nil
    
    @Published var colors: [Color]
    
    init() {
        self.colors = [Color(hex: "#327846"), Color(hex: "#97a2dd"), Color(hex: "#8400ff"), Color(hex: "#e8657f"), Color(hex: "#ff8f43")]
        self.roomService = ServiceLocator.roomService
        self.room = roomService.room

        NotificationCenter.default.addObserver(forName: .roomChanged, object: nil, queue: .main) { _ in
            self.room = self.roomService.room
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    

    
    func vote(vote:Vote) {
        Task.detached {
            let result = await self.roomService.vote(vote: vote)
            switch (result) {
            case .success:
                break;
            case .failure(let error):
                switch (error) {
                case .network:
                    self.leavingErrorMessage = "A network error occurred."
                case .unknown:
                    self.leavingErrorMessage = "An unknown error occurred."
                }
            }
        }
        
    }
    
    func leaveRoom() {
        leaving = true
        
        Task.detached {
            let result = await self.roomService.leaveRoom()
            
            switch (result) {
            case .success:
                break;
            case .failure(let error):
                switch (error) {
                case .network:
                    self.leavingErrorMessage = "A network error occurred."
                case .unknown:
                    self.leavingErrorMessage = "An unknown error occurred."
                }
                self.leaving = false
            }
        }
    }
    
}
