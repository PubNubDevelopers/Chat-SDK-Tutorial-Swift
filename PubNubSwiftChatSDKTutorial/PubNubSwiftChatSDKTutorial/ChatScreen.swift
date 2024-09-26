//
//  ChatScreen.swift
//  PubNubSwiftChatSDK
//
//  Created by Darryn Campbell on 08/09/2024.
//

import SwiftUI
import PubNubSDK
import PubNubSwiftChatSDK

struct ChatScreen : View {
    var chat: ChatImpl?
    var currentUserId: String
    @Namespace var bottom
    @State var messages = [MessageImpl]()
    @State var autoCloseable: AutoCloseable?
    @State var historicalMessageUpdateStream: AutoCloseable?
    @State var newMessageUpdateStream: AutoCloseable?
    @State var readReceiptsStream: AutoCloseable?
    @State var readReceipts = [Timetoken: [String]]()
    var activeChannel: ChannelImpl?
    var channelChanged: (_ requestedChannel: ChannelImpl?) -> Void
    @State var headerText: String = "default"
    @State var headerProfileUrl: String = TestData.DefaultProfile
    var body: some View {
        HeaderView(chatLayout: true, backFunction: {channelChanged(nil)}, title: headerText, avatarUrl: headerProfileUrl, presenceShown: (activeChannel?.type != .public))
        ScrollViewReader { scrollView in
            ScrollView {
                ForEach(messages, id: \.self.timetoken) {message in
                    MessageView(chat: chat, received: (message.userId != currentUserId), isPublicChannel: (activeChannel?.type == .public), message: message, readReceipts: readReceipts, presenceIndicator: true, messageText: message.text).id(message.timetoken)
                }
                
                //MessageView(received: true, isRead: true, presenceIndicator: true, messageText: "I am some message text")
                //MessageView(received: false, isRead: true, presenceIndicator: false, messageText: "I am some message text")
                //MessageView(received: true, isRead: false, presenceIndicator: false, messageText: "I am some message text")
                //MessageView(received: false, isRead: false, presenceIndicator: false, messageText: "I am some message text")
                //MessageView(received: true, isRead: true, presenceIndicator: true, messageText: "yo")
                //MessageView(received: true, isRead: true, presenceIndicator: false, messageText: "Very very very very very very Very very very very very very Very very very very very very Very very very very very very Very very very very very very Very very very very very very long message")
                //MessageView(received: false, isRead: true, presenceIndicator: true, messageText: "yo")
                //MessageView(received: false, isRead: false, presenceIndicator: true, messageText: "Very very very very very very Very very very very very very Very very very very very very Very very very very very very Very very very very very very Very very very very very very long message")
            }.onAppear {
                self.launch()
            }.onChange(of: messages.count) {
                _ in
                scrollView.scrollTo(messages.last?.timetoken)
            }
        }
        Spacer()
        MessageInput(activeChannel: activeChannel, sendMessage: self.sendMessage(messageText:), startTyping: self.startTyping)
    }
    
    func sendMessage(messageText: String) {
        print("Sending Message: " + messageText)
        activeChannel?.sendText(text: messageText) {
            result in
            switch result {
            case .success(let timetoken):
                debugPrint("Message sent successfully at \(timetoken)")
            case let .failure(error):
                debugPrint("Failed to send message: \(error)")
            }
        }
    }
    func startTyping() {
        let rand = Int.random(in: 0..<6)
        //print("Typing " + String(rand))
        if (activeChannel?.type != .public)
        {
            activeChannel?.startTyping()
        }
    }
    func launch() {
        if (activeChannel?.type == .public) {
            //  Public Channel Header
            headerText = activeChannel?.name ?? ""
            headerProfileUrl = activeChannel?.custom!["profileUrl"] as! String
        }
        else {
            //  Direct channel header
            activeChannel?.getMembers(limit: 2) { result in
                switch result {
                case let .success((memberships, _)):
                  debugPrint("Fetched members: \(memberships)")
                    for i in 0...memberships.count-1 {
                        print(memberships[i].user.id)
                        if (memberships[i].user.id != currentUserId)
                        {
                            //debugPrint("Fetched member: \(memberships[i].user.name)")
                            //let other: UserImpl? = memberships[i].user
                            //let otherName: String? = other?.name
                            //headerText = otherName ?? ""
                            //let newName: String = memberships[i].user.name
                            headerText = memberships[i].user.name ?? ""
                            headerProfileUrl = memberships[i].user.profileUrl ?? TestData.DefaultProfile
                        }
                    }
                    break;
                case let .failure(error):
                  debugPrint("Failed to fetch members: \(error)")
                }
            }
        }
        
        var myChannelMembership: MembershipImpl? = nil
        chat?.currentUser.getMemberships(filter: "channel.id == '" + activeChannel!.id + "'") {result in
            switch result {
            case let .success((memberships, _)):
                if (!memberships.isEmpty) {
                    myChannelMembership = memberships.first
                    debugPrint("Found a membership")
                }
                //  Stream read receipts on this channel
                if (activeChannel?.type != .public)
                {
                    readReceiptsStream = activeChannel?.streamReadReceipts { receipts in
                        print("Read Receipts Received:")
                        readReceipts = receipts
                        //receipts.forEach { (messageTimetoken, users) in
                          //print("Message Timetoken: \(messageTimetoken) was read by users: \(users)")
                        //}
                      }
                }
                debugPrint("Registering for messages")
                //  Connect to the channel to receive messages
                autoCloseable = activeChannel?.connect { message in
                    debugPrint("Received message: \(message.content.text)")
                    messages.append(message)
                    myChannelMembership?.setLastReadMessage(message: message)
                    if (!messages.isEmpty)
                    {
                        newMessageUpdateStream = MessageImpl.streamUpdatesOn(messages: messages) { updatedMessages in
                            debugPrint("Received updates for messages")
                            messages = updatedMessages
                        }
                    }
                }
                activeChannel?.getHistory(count: 20) {
                    switch $0 {
                    case let .success(response):
                        messages.append(contentsOf: response.messages)
                        if (!response.messages.isEmpty)
                        {
                            myChannelMembership?.setLastReadMessageTimetoken(response.messages.last!.timetoken)
                        }
                        if (!messages.isEmpty)
                        {
                            historicalMessageUpdateStream = MessageImpl.streamUpdatesOn(messages: messages) { updatedMessages in
                                debugPrint("Received updates for messages")
                                messages = updatedMessages
                            }
                        }

                        break
                    case let .failure(error):
                        debugPrint("Failed to fetch history data: \(error)")
                    }
                }
                break;
            case let .failure(error):
                debugPrint("Failed to fetch memberships: \(error)")
            }
        }
        


    }
}


#Preview {
    ChatScreen(currentUserId: "", channelChanged: {activeChannel in })
}
