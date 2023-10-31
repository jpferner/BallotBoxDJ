//
//  SendMessageResult.swift
//  DJApp
//
//  Created by user206471 on 12/28/21.
//

import Foundation

enum SendMessageError {
    case notFound
    case network
    case unknown
}

enum SendMessageResult {
    case success(_ chatRoom: ChatRoom)
    case failure(_ error: SendMessageError)
}
