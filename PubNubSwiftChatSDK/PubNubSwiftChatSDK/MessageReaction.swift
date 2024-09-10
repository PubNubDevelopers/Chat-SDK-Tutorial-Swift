//
//  MessageReaction.swift
//  PubNubSwiftChatSDK
//
//  Created by Darryn Campbell on 04/09/2024.
//

import SwiftUI

struct MessageReaction : View {
    let emoji: String
    let count: Int
    @State var countText: String = ""
    var body: some View {
        HStack(spacing: 0) {
            Text(emoji).font(.body).padding([.horizontal], 3)
            if (count > 0)
            {
                Text(String(count)).font(.body).foregroundStyle(.black)
            }
            else {
                Text(" ").font(.body)
            }
        }.padding(4).background(Neutral50).cornerRadius(10).padding(1).background(Neutral200).cornerRadius(10)
    }
}


#Preview {
    HStack (spacing:5) {
        MessageReaction(emoji: "🫠", count: 1)
        MessageReaction(emoji: "😀", count: 0)
        MessageReaction(emoji: "🥶", count: 10)
        MessageReaction(emoji: "🥶", count: 5)

    }
}

