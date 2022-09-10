//
//  ChatServiceImpl.swift
//  DJApp
//
//  Created by user206471 on 12/28/21.
//

import Foundation

class ChatServiceImpl: ChatService {
    var chatMessages: [ChatMessage] = []
   // var chatMessageQueue: [ChatMessage] = []
    
    func getChatRoom(id: String) async -> GetChatRoomResult {
        return .success(ChatRoom(id: "test", messages: chatMessages))
    }
    
    func sendMessage(id: String, message: ChatMessage) async -> SendMessageResult {
        chatMessages.append(message)
        return .success(ChatRoom(id: "test", messages: chatMessages))
    }
}
