//
//  ChatView.swift
//  DJApp
//
//  Created by user206471 on 12/1/21.
//

import SwiftUI


struct ChatView: View {
    var  timeFormatter: DateFormatter = {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a"
        return timeFormatter
    }()
    @State private var message: String = ""
    @StateObject private var viewModel = ChatViewModel()
    @FocusState private var chatFieldisFocused: Bool
    
    var postVotesInChat: Bool?
    
    
    var body: some View {
        VStack(alignment: .center) {
            if viewModel.loading {
                ProgressView()
                
            }
            else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            }
            else {
                Text("Party Chat")
                .font(Font.system(size: 30).bold())
                .padding()

                List {
                    
                    ForEach(viewModel.chatMessages, id: \.id) { message in
                        HStack {
                            Text("\(message.sender): ")
                            Text(message.message)
                            Spacer()
                            Text(self.timeFormatter.string(from: message.timeStamp))
                                .multilineTextAlignment(.trailing)
                                .frame(alignment: .trailing)
                        }
                        .frame(alignment: .trailing)
                        
                    }
                }
                .listStyle(.plain)
                
//                .frame(alignment: .leading)
                
                TextField("chat", text: $message)
                    .frame(alignment: .center)
                    .focused($chatFieldisFocused)
                    .onSubmit {
                        viewModel.sendMessage(message: message)
                        message = ""
    //                    post = true
                    }
            }

        }
        
        .padding()
//        .opacity(0.2)
    }
        
        
}
    

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}

//struct MessagesView: View {
//    var messages: [String]
//    
//    var body: some View {
//        
//        
//    }
//}
//
//struct MessageView: View {
//    
//    var message: String
//    
//    var body: some View {
//        Text(message)
//    }
//}
//
//struct MessageView_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageView(message: "message")
//    }
//}
