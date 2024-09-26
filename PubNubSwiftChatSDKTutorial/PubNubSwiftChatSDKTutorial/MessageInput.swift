//
//  MessageInput.swift
//  PubNubSwiftChatSDK
//
//  Created by Darryn Campbell on 08/09/2024.
//

import SwiftUI
import PubNubSDK
import PubNubSwiftChatSDK

struct MessageInput: View {
    var activeChannel: ChannelImpl?
    var sendMessage: (_ messageText: String) -> Void = {messageText in }
    var startTyping: () -> Void = {}
    @State var messageText: String = ""
    @State var typingCloseable: AutoCloseable?
    @State var somebodyIsTyping: Bool = false
    @State var typingMessage: String = ""
    var body: some View {
        VStack (alignment: .center) {
            //Color.purple.ignoresSafeArea()
            if (somebodyIsTyping)
            {
                Divider().tint(Navy200)
                TypingIndicatorView(typingMessage: typingMessage)
            }
            TextField(
                "Type Message",
                text: $messageText
            )
            .onSubmit {
                self.sendMessage(messageText)
                messageText = ""
            }
            .onChange(of: messageText) {
                if (!messageText.isEmpty)
                {
                    startTyping()
                }
            }
            .font(.body)
            padding()
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .border(.secondary).padding()
        }.onAppear {
            self.launch()
        }
    }
    
    func launch()
    {
        typingCloseable = activeChannel?.getTyping {
            typingUsers in
            debugPrint("Typing users: \(typingUsers)")
            if (typingUsers.isEmpty)
            {
                somebodyIsTyping = false
                typingMessage = ""
            }
            else
            {
                somebodyIsTyping = true
                typingMessage = "Typing: " + typingUsers.joined(separator: ", ")
            }
        }
    }
}

#Preview {
    MessageInput()
}
