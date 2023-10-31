//
//  ChatViewModel.swift
//  DJApp
//
//  Created by user206471 on 12/28/21.
//

import Foundation

class ChatViewModel: ObservableObject {
    private var chatService: ChatService = ServiceLocator.chatService
    private var chatMessageQueue: [ChatMessage] = []
    private var chatRoom: ChatRoom?
    private var voteNotifications: [ChatMessage] = []
    
    @Published var loading: Bool = false
    @Published var errorMessage: String?
    @Published var chatMessages: [ChatMessage] = []
    
    init() {
        loadChatRoom()
        Task.detached {
            while true {
                if let message = await self.getQueuedMessage() {
                    let result = await self.chatService.sendMessage(id: "test", message: message)
                    switch result {
                    case .success(let chatRoom):
                        DispatchQueue.main.async {
                            self.chatRoom = chatRoom
                            self.updateMessages()
                            
                        }
                        await self.removeQueuedMessage()
                    case .failure(_ ):
                        try await Task.sleep(nanoseconds: 100000000)
                    }
                }
                else {
                    try await Task.sleep(nanoseconds: 500000000)
                }
            }
        }
    }
    
    @MainActor func getQueuedMessage() -> ChatMessage? {
        return chatMessageQueue.first
    }
    
    @MainActor func removeQueuedMessage() {
        chatMessageQueue.remove(at: 0)
        
    }
    
    func loadChatRoom() {
        loading = true
        Task.detached {
            let result = await self.chatService.getChatRoom(id: "test")
            switch result {
            case .success(let chatRoom):
                self.chatRoom = chatRoom
                DispatchQueue.main.async {
                    self.loading = false
                    self.errorMessage = nil
                    self.updateMessages()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    switch error {
                    default:
                        self.errorMessage = "error"
                        
                    }
                    self.loading = false
                    
                }
            }
        }
    }
    
    func sendMessage(message: String) {
        let chatMessage = ChatMessage(id: UUID().uuidString, timeStamp: Date(), sender: "jake", message: message)
        self.chatMessageQueue.append(chatMessage)
        self.updateMessages()
    }
    
    func updateMessages() {
        guard let chatRoom = self.chatRoom else {
            return
        }
        
        var chatMessages: [ChatMessage] = []
        chatMessages.append(contentsOf: chatRoom.messages)
        
        for message in self.chatMessageQueue {
            var found: Bool = false
            for existingMessage in chatMessages {
                if message.id == existingMessage.id {
                    found = true
                    break
                }
            }
            if !found {
                chatMessages.append(message)
            }
        }
        chatMessages.sorted {
            if $0.timeStamp == $1.timeStamp {
                return $0.id > $1.id
            }
            else {
                return $0.timeStamp > $1.timeStamp

            }
            
        }
        self.chatMessages = chatMessages
    }
    
    
}
