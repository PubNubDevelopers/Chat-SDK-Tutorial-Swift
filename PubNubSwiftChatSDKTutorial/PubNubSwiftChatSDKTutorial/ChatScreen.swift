//
//  ChatScreen.swift
//  PubNubSwiftChatSDK
//
//  Created by Darryn Campbell on 08/09/2024.
//

import SwiftUI

struct ChatScreen : View {
    var activeChannel: String = ""
    var channelChanged: (_ activeChannel: String) -> Void
    var body: some View {
        HeaderView(chatLayout: true, backFunction: {channelChanged("")}, title: "TEST - General Chat", avatarUrl: "https://chat-sdk-demo-web.netlify.app/avatars/placeholder2.png")
        ScrollView {
            MessageView(received: true, isRead: true, presenceIndicator: true, messageText: "I am some message text")

            MessageView(received: false, isRead: true, presenceIndicator: false, messageText: "I am some message text")
            
            MessageView(received: true, isRead: false, presenceIndicator: false, messageText: "I am some message text")

            MessageView(received: false, isRead: false, presenceIndicator: false, messageText: "I am some message text")
            
            MessageView(received: true, isRead: true, presenceIndicator: true, messageText: "yo")

            MessageView(received: true, isRead: true, presenceIndicator: false, messageText: "Very very very very very very Very very very very very very Very very very very very very Very very very very very very Very very very very very very Very very very very very very long message")
            
            MessageView(received: false, isRead: true, presenceIndicator: true, messageText: "yo")
            
            MessageView(received: false, isRead: false, presenceIndicator: true, messageText: "Very very very very very very Very very very very very very Very very very very very very Very very very very very very Very very very very very very Very very very very very very long message")
        }
        Spacer()
        MessageInput(sendMessage: self.sendMessage(messageText:), startTyping: self.startTyping)
    }
    
    func sendMessage(messageText: String) {
        print("Sending Message: " + messageText)
    }
    func startTyping() {
        let rand = Int.random(in: 0..<6)
        print("Typing " + String(rand))
    }
}


#Preview {
    ChatScreen(channelChanged: {activeChannel in })
}
