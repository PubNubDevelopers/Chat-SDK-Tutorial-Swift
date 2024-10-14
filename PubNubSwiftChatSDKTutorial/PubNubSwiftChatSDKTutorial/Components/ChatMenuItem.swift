//
//  ChatMenuItem.swift
//  PubNubSwiftChatSDK
//
//  Created by Darryn Campbell on 08/09/2024.
//

import SwiftUI
import PubNubSDK
import PubNubSwiftChatSDK

struct ChatMenuItem: View {
    var avatarUrl: URL
    var chatTitle: String
    var userSelected: (UserImpl) -> Void = {_ in}
    var channelSelected: (ChannelImpl) -> Void = { _ in}
    var stateChannel: ChannelImpl?
    var stateUser: UserImpl?
    var body: some View {
        HStack (){
            AvatarView(url: avatarUrl, presenceShown: false, size: 40).padding(.leading, 15).padding(.trailing, 8).padding(.vertical, 4)
            Text(chatTitle).font(.body)
        }.frame(maxWidth: .infinity, alignment: .leading).contentShape(Rectangle())
            .onTapGesture {
                if (stateUser != nil) {
                    userSelected(stateUser!)
                }
                if (stateChannel != nil) {
                    channelSelected(stateChannel!)
                }
            }
    }
}

#Preview {
    VStack {
        ChatMenuItem(avatarUrl: URL(string: "https://chat-sdk-demo-web.netlify.app/group/globe1.png")!, chatTitle: "General Chat")
        ChatMenuItem(avatarUrl: URL(string: "https://chat-sdk-demo-web.netlify.app/group/globe2.png")!, chatTitle: "Work Chat")
    }
    
}
