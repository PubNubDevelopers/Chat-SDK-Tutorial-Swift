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
    @State var chat: ChatImpl? = nil
    @State var activeChannel: ChannelImpl? = nil
    @State var publicChannels = [ChannelImpl]()
    @State var allUsers = [UserImpl]()
    var body: some View {
        if (activeChannel == nil)
        {
            //  Home screen (choose a chat)
            VStack{
                HeaderView(chatLayout: false)
                ScrollView {
                    ChatMenuGroup(chat: chat, groupName: "PUBLIC CHANNELS", channels: publicChannels, users: nil, userSelected: self.userSelected, channelSelected: self.channelSelected)
                    ChatMenuGroup(chat: chat, groupName: "DIRECT MESSAGES", channels: nil, users: allUsers, userSelected: self.userSelected, channelSelected: self.channelSelected)
                }
                Spacer()
                NavBar(logout: logout)
            }.onAppear { self.launch() }
        }
        else
        {
            //  Chat Screen
            ChatScreen(chat: chat, currentUserId: chat?.currentUser.id ?? "", activeChannel: activeChannel, channelChanged: self.channelChanged)
        }
    }
    
    func launch() {
        if (userId.isEmpty) {return}
        if (!publicChannels.isEmpty) {return}
        print("Launching " + userId)

        
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
    func userSelected(selectedUser: UserImpl) {
        //  todo show loading spinner
        print("User Selected")
        chat?.createDirectConversation(invitedUser: selectedUser) {
            switch $0 {
            case let .success(conversationResult):
                let channel = conversationResult.channel
                activeChannel = channel
            case let .failure(error):
                debugPrint("Failed to create direct conversation: \(error)")
            }
        }
        
    }
    func channelSelected(channel: ChannelImpl) {
        print("Channel Selected")
        activeChannel = channel
    }
    func channelChanged(_ newChannel: ChannelImpl?) {
        activeChannel = newChannel
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
        //  todo there's something wrong here, the order returned isn't consistent
        let channelOrder : PubNub.ObjectSortField = .init(property: .id, ascending: true)
        chat?.getChannels(filter: "id LIKE \"public*\"", sort: [channelOrder]) {
            switch $0 {
            case let .success((channels)):
                publicChannels = channels.channels
                if (channels.channels.isEmpty)
                {
                    //  The public channels do not exist on this keyset
                    let customObjectGeneral = ["profileUrl": TestData.AvatarBaseUrl + "/group/globe1.png"]
                    chat?.createPublicConversation(
                        channelId: "public-general",
                        channelName: "General Chat",
                        channelDescription: "Public group for general conversation",
                        channelCustom: customObjectGeneral
                    ) {
                        switch $0 {
                        case let .success(_):
                            let customObjectWork = ["profileUrl":  TestData.AvatarBaseUrl + "/group/globe2.png"]
                            chat?.createPublicConversation(
                                channelId: "public-work",
                                channelName: "Work Chat",
                                channelDescription: "Public group  conversation about work",
                                channelCustom: customObjectWork
                            ) {_ in 
                                print("Public conversations successfully created")
                                chat?.getChannels(filter: "id LIKE \"public*\"") {
                                    switch $0 {
                                    case let .success((channels)):
                                        publicChannels = channels.channels
                                        break;
                                    case let .failure(error):
                                        print("Error: \(error)")
                                    }
                                }
                            }
                            break
                        case let .failure(error):
                            debugPrint("Failed to create public conversation: \(error)")
                        }
                    }
                }

                break;
            case let .failure(error):
                print("Error: \(error)")
            }
        }
        //  Get all the users.  This simple application will display all recent users and allow you to just click on somebody to start a direct conversation with them
        let order : PubNub.ObjectSortField = .init(property: .updated, ascending: false)
        chat?.getUsers(sort: [order], limit: 15) {
            switch $0 {
            case let .success((users, _)):
                allUsers = users
                break;
            case let .failure(error):
                debugPrint("Failed to fetch user IDs: \(error)")

            }
        }
    }
    
}

#Preview {
    HomeScreen(logout: {}, userId: "", username: "")
}
