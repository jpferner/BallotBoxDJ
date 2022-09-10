//
//  ChatMessage.swift
//  DJApp
//
//  Created by user206471 on 12/28/21.
//

import Foundation


//enum ChatMessage {
  //  case dialogue (message: Dialogue)
  //  case voteMessage (message: VoteMessage)
//}

struct ChatMessage {
    var id: String
    var timeStamp: Date
    var sender: String
    var message: String
}
