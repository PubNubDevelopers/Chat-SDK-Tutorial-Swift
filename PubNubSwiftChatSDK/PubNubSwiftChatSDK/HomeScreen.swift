//
//  HomeScreen.swift
//  PubNubSwiftChatSDK
//
//  Created by Darryn Campbell on 05/09/2024.
//

import SwiftUI

struct HomeScreen: View {
    var logout: () -> Void
    @State var showChatScreen: Bool = false
    var body: some View {
        if (!showChatScreen)
        {
            //  Home screen (choose a chat)
            VStack{
                HeaderView(chatLayout: false)
                ScrollView {
                    ChatMenuGroup(groupName: "PUBLIC CHANNELS", userSelected: self.userSelected, channelSelected: self.channelSelected)
                    ChatMenuGroup(groupName: "DIRECT MESSAGES", userSelected: self.userSelected, channelSelected: self.channelSelected)
                }
                Spacer()
                NavBar(logout: logout)
            }
        }
        else
        {
            //  Chat Screen
            ChatScreen(channelChanged: self.channelChanged)
        }
    }
    func userSelected() {
        print("User Selected")
        showChatScreen = true
    }
    func channelSelected() {
        print("Channel Selected")
    }
    func channelChanged(_ activeChannel: String) {
        showChatScreen = false
    }
}

#Preview {
    HomeScreen(logout: {})
}
