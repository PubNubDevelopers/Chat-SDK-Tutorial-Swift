//
//  ChatMenuGroup.swift
//  PubNubSwiftChatSDK
//
//  Created by Darryn Campbell on 08/09/2024.
//

import SwiftUI

struct ChatMenuGroup: View {
    var groupName: String
    var userSelected: () -> Void = {}
    var channelSelected: () -> Void = {}
    var body: some View {
        VStack (alignment: .leading){
            Divider().tint(Navy200)
            Text(groupName).font(.body).padding()
            ChatMenuItem(avatarUrl: URL(string: "https://chat-sdk-demo-web.netlify.app/group/globe1.png")!, chatTitle: "General Chat", userSelected: userSelected, channelSelected: channelSelected)
            ChatMenuItem(avatarUrl: URL(string: "https://chat-sdk-demo-web.netlify.app/group/globe2.png")!, chatTitle: "Work Chat", userSelected: userSelected, channelSelected: channelSelected)
            Text("")
        }
    }
}

#Preview {
    VStack {
        ChatMenuGroup(groupName: "PUBLIC CHANNELS")
        ChatMenuGroup(groupName: "DIRECT MESSAGES")
        
    }

}
