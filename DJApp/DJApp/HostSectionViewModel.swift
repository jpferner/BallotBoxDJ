//
//  HostSectionViewModel.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

//extension Color {
//    init(hex: String) {
//        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
//      var int: UInt64 = 0
//        Scanner(string: hex).scanHexInt64(&int)
//        let a, r, g, b: UInt64
//        switch hex.count {
//        case 3: // RGB (12-bit)
//            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
//        case 6: // RGB (24-bit)
//            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
//        case 8: // ARGB (32-bit)
//            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
//        default:
//            (a, r, g, b) = (1, 1, 1, 0)
//        }
//
//        self.init(
//            .sRGB,
//            red: Double(r) / 255,
//            green: Double(g) / 255,
//            blue:  Double(b) / 255,
//            opacity: Double(a) / 255
//        )
//    }
//}
import SwiftUI
import Foundation

class HostSectionViewModel: ObservableObject {
    
    let roomService: RoomService
    let musicService: MusicService
    
//    var allColors = [ColorScheme(color1: Color(hex: "#7BAFD4"),color2: Color(hex: "#FFFFFF")), //carolina
//                     ColorScheme(color1: Color(hex: "#006666"),color2: Color(hex: "#003366")), //uncw
//                     ColorScheme(color1: Color(hex: "#F56600"),color2: Color(hex: "#522D80")), //clemson
//                     ColorScheme(color1: Color(hex: "#6A2C3E"),color2: Color(hex: "#CF4520")), //virginia tech
//                     ColorScheme(color1: Color(hex: "#782F40"),color2: Color(hex: "#CEB888")), //florida state
//                     ColorScheme(color1: Color(hex: "#9E7E38"),color2: Color(hex: "#000000")), //wake
//                     ColorScheme(color1: Color(hex: "#8f2e71"),color2: Color(hex: "#ffaa66")), //default
//                     ColorScheme(color1: Color(hex: "#BA0C2F"),color2: Color(hex: "#000000")), //florida state
//                     ColorScheme(color1: Color(hex: "#782F40"),color2: Color(hex: "#CEB888")), //florida state
//                     ColorScheme(color1: Color(hex: "#782F40"),color2: Color(hex: "#CEB888")), //florida state
//                     ColorScheme(color1: Color(hex: "#782F40"),color2: Color(hex: "#CEB888")), //florida state
//                     ColorScheme(color1: Color(hex: "#006400"),color2: Color(hex: "#640064"))
//
//                     ]
    
    @Published var colors: [Color]
    @Published var room: Room?
    @Published var provider: Provider?
    @Published var playlist: Playlist?


    @Published var leaving = false
    @Published var leavingErrorMessage: String? = nil
    
    @Published var toggleSettingValues = false
    @Published var settingsState = SettingsState(allowChangingVotes: true, postVotesInChat: false)
    
    init() {
        self.colors = [Color(hex: "#9d3922"), Color(hex: "#bf1989"), Color(hex: "#327846"), Color(hex: "#00ffef"), Color(hex: "#ee92f4"), Color(hex: "#8400ff"), Color(hex: "#ee92f4")]
        self.roomService = ServiceLocator.roomService
        self.room = roomService.room
        
       // self.settingValue = roomService.room!.settingsValues!
        
        self.musicService = ServiceLocator.musicService
        self.provider = self.musicService.provider
        self.playlist = self.musicService.currentPlaylist
        
        NotificationCenter.default.addObserver(forName: .providerUpdated, object: nil, queue: .main) { _ in
            self.provider = self.musicService.provider
        }
        NotificationCenter.default.addObserver(forName: .playlistSelected, object: nil, queue: .main) { _ in
            self.playlist = self.musicService.currentPlaylist
        }
        NotificationCenter.default.addObserver(forName: .roomChanged, object: nil, queue: .main) { _ in
            self.room = self.roomService.room
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func onChanged(_ playlist: Playlist?) {
        self.playlist = playlist
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
