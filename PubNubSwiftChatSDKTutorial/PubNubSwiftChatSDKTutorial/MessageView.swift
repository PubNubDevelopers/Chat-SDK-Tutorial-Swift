//
//  Message.swift
//  PubNubSwiftChatSDK
//
//  Created by Darryn Campbell on 08/09/2024.
//

import SwiftUI
import PubNubSDK
import PubNubSwiftChatSDK

struct MessageView: View {
    var chat: ChatImpl?
    var received: Bool
    var isPublicChannel: Bool
    var message: MessageImpl?
    var readReceipts: [Timetoken: [String]]
    @State var isRead: Bool = false
    var presenceIndicator: Bool = false
    @State var senderName: String = "Default Username"
    @State var avatarUrl: String = TestData.DefaultProfile
    var messageText: String
    
    var body: some View {
        
        if (received)
        {
            //  Received Message
            //Text(messageText).font(.callout).frame(maxWidth: .infinity, alignment: .leading).padding(.leading)
            HStack()
            {
                HStack(alignment: VerticalAlignment.top){
                    AvatarView(url: URL(string: avatarUrl)!, presenceColor: getPresenceColor(presenceIndicator: presenceIndicator), size: 40)
                    VStack(alignment: .leading) {
                        Text(senderName).font(.callout)
                        ZStack (alignment: .leading){
                            Neutral50
                            VStack (alignment: .leading)
                            {

                                Text(messageText).font(.body).frame(maxWidth: UIScreen.main.bounds.size.width - 90, alignment: .leading).padding(5)
                                //  Area for Emoji
                                HStack (alignment: .top) {
                                    MessageReactionView(message: message, emoji: "😀")
                                    MessageReactionView(message: message, emoji: "🥶")
                                }.frame(maxWidth: .infinity, alignment: .trailing)
                                Spacer()
                            }.padding([.vertical], 5).padding([.horizontal], 8)
                            
                        }.clipShape(.rect(
                            topLeadingRadius: 0,
                            bottomLeadingRadius: 20,
                            bottomTrailingRadius: 20,
                            topTrailingRadius: 20))
                        Spacer()
                        
                    }
                }.fixedSize().frame(alignment: .leading).padding(.horizontal)
            }.frame(maxWidth: .infinity, alignment: .leading).onAppear {
                self.launch(chat: chat)
            }

        }
        else
        {
            //  Sent message
            //Text(messageText).font(.callout).frame(maxWidth: .infinity, alignment: .leading).padding(.leading)
            
            HStack()
            {
                HStack(alignment: VerticalAlignment.top){
                    

                    VStack(alignment: .leading) {

                        ZStack (alignment: .leading){
                            Teal100
                            VStack (alignment: .leading)
                            {
                                Text(messageText).font(.body).fixedSize(horizontal: false, vertical: true).frame(alignment: .leading).padding(5)
                                //  Area for Emoji
                                HStack (alignment: .top, spacing: 2) {
                                    MessageReactionView(message: message, emoji: "😀")
                                    MessageReactionView(message: message, emoji: "🥶")
                                    if (!isPublicChannel)
                                    {
                                        if (processReadReceipts(readReceipts: readReceipts))
                                        {
                                            MessageReadReceipt(isRead: true).padding(4)
                                        }
                                        else
                                        {
                                            MessageReadReceipt(isRead: false).padding(4)
                                        }
                                        //if (!readReceipts.isEmpty)
                                        //{
                                            //debugPrint("Darryn read receipt update")
                                            //MessageReadReceipt(isRead: true).padding(4)
                                            //debugPrint(receipt)
                                        //}
                                        
                                        
                                    }
                                }.frame(maxWidth: .infinity, alignment: .trailing)

                            }.padding([.vertical], 8).padding([.horizontal], 8)
                        }.clipShape(.rect(
                            topLeadingRadius: 20,
                            bottomLeadingRadius: 20,
                            bottomTrailingRadius: 20,
                            topTrailingRadius: 0))
                        
                    }.padding([.leading], 100)
                }.frame(alignment: .leading).padding(.horizontal)
            }.frame(maxWidth: .infinity, alignment: .trailing).padding(.vertical).onAppear {
                self.launch(chat: chat)
            }
        }
    }
    func launch(chat: ChatImpl?) {
        chat?.getUser(
            userId: message?.userId ?? "unknown"
        ) {
          switch $0 {
          case let .success(user):
            if let user = user {
              debugPrint("Fetched user metadata with ID: \(user.id)")
                senderName = user.name ?? "Unknown User"
                avatarUrl = user.profileUrl ?? TestData.DefaultProfile
            } else {
              debugPrint("User not found")
            }
          case let .failure(error):
            debugPrint("Failed to fetch user metadata: \(error)")
          }
        }
        //  Work out if the message is read
        //if (!isPublicChannel)
        //{
        //    debugPrint("Launch for MessageView")
        //    readReceipts.forEach {receipt in
        //        debugPrint("Darryn")
        //        debugPrint(receipt)
        //    }
        //}
    }
    func getPresenceColor(presenceIndicator: Bool) -> Color
    {
        var presenceColor: Color = Neutral300
        if (presenceIndicator){
            presenceColor = StatusIndicatorSuccess
        }
        return presenceColor
    }
    
    func processReadReceipts(readReceipts: [Timetoken: [String]]) -> Bool
    {
        debugPrint(readReceipts)
        var isRead = false
        readReceipts.forEach {(messageTimetoken, users) in
            print("Message Timetoken: \(messageTimetoken) was read by users: \(users)")
            if (messageTimetoken >= message!.timetoken) {
                if ((!users.isEmpty && !users.contains((chat?.currentUser.id)!)) || users.count > 1) {
                    isRead = true
                }
            }
        }
        return isRead
    }
}

#Preview {
    VStack {
        ScrollView
        {
            //MessageView(received: true, isPublicChannel: false, isRead: true, presenceIndicator: true, messageText: "I am some message text")
            //MessageView(received: false, isPublicChannel: false,isRead: true, presenceIndicator: false, messageText: "I am some message text")
            //MessageView(received: true, isPublicChannel: false,isRead: false, presenceIndicator: false, messageText: "I am some message text")
            //MessageView(received: false, isPublicChannel: false,isRead: false, presenceIndicator: false, messageText: "I am some message text")
            //MessageView(received: true, isPublicChannel: false,isRead: true, presenceIndicator: true, messageText: "yo")
            //MessageView(received: true, isPublicChannel: false,isRead: true, presenceIndicator: false, messageText: "Very very very very very very Very very very very very very Very very very very very very Very very very very very very Very very very very very very Very very very very very very long message")
            //MessageView(received: false, isPublicChannel: false,isRead: true, presenceIndicator: true, messageText: "yo")
            //MessageView(received: false, isPublicChannel: false,isRead: true, presenceIndicator: true, messageText: "Very very very very very very Very very very very very very Very very very very very very Very very very very very very Very very very very very very Very very very very very very long message")
            //MessageView(received: true, isPublicChannel: false,isRead: true, presenceIndicator: true, messageText: "yo")
        }

    }
    
    
    
}

