//
//  ChatMenuGroup.swift
//  PubNubSwiftChatSDK
//
//  Created by Darryn Campbell on 08/09/2024.
//

import SwiftUI
import PubNubSDK
import PubNubSwiftChatSDK

struct ChatMenuGroup: View {
    var chat: ChatImpl?
    var groupName: String
    var channels : [ChannelImpl]?
    var users : [UserImpl]?
    var userSelected: (UserImpl) -> Void = {_ in }
    var channelSelected: (ChannelImpl) -> Void = {_ in}
    var body: some View {
        VStack (alignment: .leading){
            Divider().tint(Navy200)
            Text(groupName).font(.body).padding()
            if (channels != nil)
            {
                ForEach(channels!, id: \.self.id) {channel in
                    ChatMenuItem(avatarUrl: URL(string: channel.custom!["profileUrl"] as! String)!, chatTitle: channel.name ?? "Unknown Channel", userSelected: userSelected, channelSelected: channelSelected, stateChannel: channel, stateUser: nil)
                }
            }
            if (users != nil)
            {
                ForEach(users!, id: \.self.id) {user in
                    if (user.id != chat?.currentUser.id && user.id != "PUBNUB_INTERNAL_MODERATOR") {
                        ChatMenuItem(avatarUrl: URL(string: user.profileUrl ?? "https://chat-sdk-demo-web.netlify.app/avatars/placeholder2.png")!, chatTitle: user.name ?? "Unknown Channel", userSelected: userSelected, channelSelected: channelSelected, stateChannel: nil, stateUser: user)
                    }
                }
            }
            Text("")
        }
    }
}

#Preview {
    VStack {
        ChatMenuGroup(groupName: "PUBLIC CHANNELS", channels: nil)
        ChatMenuGroup(groupName: "DIRECT MESSAGES", channels: nil)
        
    }

}
