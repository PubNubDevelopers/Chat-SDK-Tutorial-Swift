//
//  Message.swift
//  PubNubSwiftChatSDK
//
//  Created by Darryn Campbell on 08/09/2024.
//

import SwiftUI

struct Message: View {
    var received: Bool
    var isRead: Bool
    var presenceIndicator: Bool = false
    var username: String = "Default Username"
    var messageText: String
    
    var body: some View {
        
        
        if (received)
        {
            //  Received Message
            //Text(messageText).font(.callout).frame(maxWidth: .infinity, alignment: .leading).padding(.leading)
            HStack()
            {
                HStack(alignment: VerticalAlignment.top){
                    AvatarView(url: URL(string: "https://chat-sdk-demo-web.netlify.app/avatars/placeholder2.png")!, presenceColor: getPresenceColor(presenceIndicator: presenceIndicator), size: 40)
                    VStack(alignment: .leading) {
                        Text(username).font(.callout)
                        ZStack (alignment: .leading){
                            Neutral50
                            VStack (alignment: .leading)
                            {

                                Text(messageText).font(.body).frame(maxWidth: UIScreen.main.bounds.size.width - 90, alignment: .leading).padding(5)
                                //  Area for Emoji
                                HStack (alignment: .top) {
                                    MessageReaction(emoji: "😀", count: 0)
                                    MessageReaction(emoji: "🥶", count: 5)
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
            }.frame(maxWidth: .infinity, alignment: .leading)

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
                                    MessageReaction(emoji: "😀", count: 0)
                                    MessageReaction(emoji: "🥶", count: 5)
                                    MessageReadReceipt(isRead: isRead).padding(4)
                                }.frame(maxWidth: .infinity, alignment: .trailing)

                            }.padding([.vertical], 8).padding([.horizontal], 8)
                        }.clipShape(.rect(
                            topLeadingRadius: 20,
                            bottomLeadingRadius: 20,
                            bottomTrailingRadius: 20,
                            topTrailingRadius: 0))
                        
                    }.padding([.leading], 100)
                }.frame(alignment: .leading).padding(.horizontal)
            }.frame(maxWidth: .infinity, alignment: .trailing).padding(.vertical)
        }
    }
    func getPresenceColor(presenceIndicator: Bool) -> Color
    {
        var presenceColor: Color = Neutral300
        if (presenceIndicator){
            presenceColor = StatusIndicatorSuccess
        }
        return presenceColor
    }
}

#Preview {
    VStack {
        ScrollView
        {
            
            Message(received: true, isRead: true, presenceIndicator: true, messageText: "I am some message text")

            Message(received: false, isRead: true, presenceIndicator: false, messageText: "I am some message text")
            
            Message(received: true, isRead: false, presenceIndicator: false, messageText: "I am some message text")

            Message(received: false, isRead: false, presenceIndicator: false, messageText: "I am some message text")
            
            Message(received: true, isRead: true, presenceIndicator: true, messageText: "yo")

            Message(received: true, isRead: true, presenceIndicator: false, messageText: "Very very very very very very Very very very very very very Very very very very very very Very very very very very very Very very very very very very Very very very very very very long message")
            
            Message(received: false, isRead: true, presenceIndicator: true, messageText: "yo")
            
            Message(received: false, isRead: true, presenceIndicator: true, messageText: "Very very very very very very Very very very very very very Very very very very very very Very very very very very very Very very very very very very Very very very very very very long message")

            Message(received: true, isRead: true, presenceIndicator: true, messageText: "yo")

        }

    }
    
    
    
}

