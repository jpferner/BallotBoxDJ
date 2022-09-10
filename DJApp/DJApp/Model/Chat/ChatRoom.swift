//
//  ChatRoom.swift
//  DJApp
//
//  Created by user206471 on 12/28/21.
//

import Foundation


struct ChatRoom {
    var id: String
    var messages: [ChatMessage]
    var voteMessages: [VoteMessage]?
}
