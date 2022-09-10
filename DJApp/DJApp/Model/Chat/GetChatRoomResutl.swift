//
//  GetChatRoomResutl.swift
//  DJApp
//
//  Created by user206471 on 12/28/21.
//

import Foundation

enum GetChatRoomError {
    case notFound
    case network
    case unknown
}

enum GetChatRoomResult {
    case success(_ chatRoom: ChatRoom)
    case failure(_ error: GetChatRoomError)
}
