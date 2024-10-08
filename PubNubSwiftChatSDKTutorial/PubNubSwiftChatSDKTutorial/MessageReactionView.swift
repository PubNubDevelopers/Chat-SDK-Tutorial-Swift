//
//  MessageReaction.swift
//  PubNubSwiftChatSDK
//
//  Created by Darryn Campbell on 04/09/2024.
//

import SwiftUI
import PubNubSDK
import PubNubSwiftChatSDK

struct MessageReactionView : View {
    let message: MessageImpl?
    let emoji: String
    @State var countText: String = ""
    var body: some View {
        HStack(spacing: 0) {
            Text(emoji).font(.body).padding([.horizontal], 3)
            let count = message?.actions?["reactions"]?[emoji]?.count ?? 0
            if (count > 0)
            {
                Text(String(count)).font(.body).foregroundStyle(.black)
            }
            else {
                Text(" ").font(.body)
            }
        }.padding(4).background(Neutral50).cornerRadius(10).padding(1).background(Neutral200).cornerRadius(10)
            .onTapGesture {
                debugPrint("Pressing Message Reaction")
                message?.toggleReaction(reaction: emoji)
            }
    }
}


#Preview {
    HStack (spacing:5) {
        //MessageReactionView(emoji: "🫠", count: 1)
        //MessageReactionView(emoji: "😀", count: 0)
        //MessageReactionView(emoji: "🥶", count: 10)
        //MessageReactionView(emoji: "🥶", count: 5)

    }
}

