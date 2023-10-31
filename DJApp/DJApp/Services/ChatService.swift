//
//  ChatService.swift
//  DJApp
//
//  Created by user206471 on 12/28/21.
//

import Foundation

protocol ChatService {
    func getChatRoom(id: String) async -> GetChatRoomResult
    func sendMessage(id: String, message: ChatMessage) async -> SendMessageResult
    
}
