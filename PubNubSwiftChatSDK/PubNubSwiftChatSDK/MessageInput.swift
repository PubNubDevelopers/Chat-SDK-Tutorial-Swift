//
//  MessageInput.swift
//  PubNubSwiftChatSDK
//
//  Created by Darryn Campbell on 08/09/2024.
//

import SwiftUI

struct MessageInput: View {
    var activeChannel: String = "TEMP"
    var sendMessage: (_ messageText: String) -> Void = {messageText in }
    var startTyping: () -> Void = {}
    @State var messageText: String = ""
    var body: some View {
        VStack (alignment: .center) {
            //Color.purple.ignoresSafeArea()
            Divider().tint(Navy200)
            TypingIndicator()
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
            .padding()
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .border(.secondary).padding()
        }
        
    }
}

#Preview {
    MessageInput()
}
