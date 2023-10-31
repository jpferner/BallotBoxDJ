//
//  MockRoomRepository.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import Foundation

class MockRoomRepository: RoomRepository {
    
    @Published var room: Room = Room(id: "room-1",
                                     name: "room",
                                     code: "ABC-DEF",
                                     hosting: true,
                                     currentSong: nil,
                                     nominations: (Song(id: "15615", provider: .spotify, title: "Every Little Thing She Does is Magic", artist: "The Police"), Song(id: "48118", provider: .spotify, title: "Levels", artist: "Aviici")),
                                     vote: nil,
                                     voteTally: VoteTally(song1: 3, song2: 6, random: 1),
                                     settingsState: SettingsState(allowChangingVotes: false, postVotesInChat: false)
                                 //    settingsValues: [.toggle(value: false)]
                                     
                                    )
    
    func hostRoom(_ name: String) async -> HostRoomResult {
        await Task.sleep(UInt64(Double(NSEC_PER_SEC)))
        return .success(self.room)
//        return .failure(.network)
    }
    
    func joinRoom(_ code: String) async -> JoinRoomResult {
        await Task.sleep(UInt64(Double(NSEC_PER_SEC)))
        return .success
    }
    
    func vote(_ vote: Vote) async -> VoteResult {
        
        
        
        if self.room.vote != vote {
            switch (vote) {
            case .song(self.room.nominations!.0):
                self.room.voteTally.song1 += 1
            case .song(self.room.nominations!.1):
                self.room.voteTally.song2 += 1
                
            case .random:
                self.room.voteTally.random += 1
            default:
                break        }
            
            if self.room.vote != nil {
                switch (self.room.vote) {
                case .song(self.room.nominations!.0):
                    self.room.voteTally.song1 -= 1
                case .song(self.room.nominations!.1):
                    self.room.voteTally.song2 -= 1
                case .random:
                    self.room.voteTally.random -= 1
                default:
                    break
                }
            }
            self.room.vote = vote
            
            
        }
        
        return .success(self.room)

  //      return .success(Room(id: "room-1",
    //                              name: "ourRoom",
      //                            code: "ABC-DEF",
        //                          hosting: true,
          //                        currentSong: nil,
            //                 nominations: (Song(id: "15615", provider: .spotify, title: "Every Little Thing She Does is Magic", artist: "The Police"), Song(id: "48118", provider: .spotify, title: "Levels", artist: "Aviici")),
              //                    vote: vote,
                //                    voteTally: VoteTally(song1: 5, song2: 2, random: 1),
                             
                  //           settingsValues:
                    //            ["Post Votes in Chat": false, "Allow Changing Votes": false]
                      //           ))
    }
    
}
