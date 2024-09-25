//
//  HomeScreen.swift
//  PubNubSwiftChatSDK
//
//  Created by Darryn Campbell on 05/09/2024.
//

import SwiftUI
import PubNubSDK
import PubNubSwiftChatSDK

struct HomeScreen: View {
    var logout: () -> Void
    var userId: String
    var username: String
    @State var showChatScreen: Bool = false
    @State var chat: ChatImpl? = nil
    //@State var publicChannels: [ChannelImpl]() //  = []
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
            }.onAppear { self.launch() }
        }
        else
        {
            //  Chat Screen
            ChatScreen(channelChanged: self.channelChanged)
        }
    }
    
    func launch() {
        print("Launching " + userId)
        if (userId.isEmpty) {return}
        
        
        //  Initialize PubNub Chat
        let pubNubConfiguration = PubNubConfiguration(
            publishKey: Keys.PUBNUB_PUBLISH_KEY,
            subscribeKey: Keys.PUBNUB_SUBSCRIBE_KEY,
            userId: userId
            // Add other required parameters
        )
        // Create Chat configuration
        let chatConfiguration = ChatConfiguration(
            // Fill in the necessary parameters for ChatConfiguration
        )

        // Create ChatImpl instance
        chat = ChatImpl(
            chatConfiguration: chatConfiguration,
            pubNubConfiguration: pubNubConfiguration
        )

        // Initialize the ChatImpl instance
        chat?.initialize { result in
            switch result {
            case .success(_):
                debugPrint("Initialized successfully!")
                postInitialize(chat: chat)
            case .failure(let error):
                debugPrint("Error during initialization: \(error)")
            }
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
    func postInitialize(chat: ChatImpl?) {
        //  Update the metadata associated with myself if this is the first time I have logged in
        if (chat?.currentUser.profileUrl == nil) {
            let randomProfileUrl =
            TestData.AvatarBaseUrl + TestData.TestAvatars[Int.random(in: 0..<TestData.TestAvatars.endIndex)]
            chat?.currentUser.update(name: username, profileUrl: randomProfileUrl)
        }
        else {
            print("Chat Profile was not empty")
        }
    }
    
}

#Preview {
    HomeScreen(logout: {}, userId: "", username: "")
}
