//
//  TypingIndicator.swift
//  PubNubSwiftChatSDK
//
//  Created by Darryn Campbell on 08/09/2024.
//

import SwiftUI

struct TypingIndicatorView: View {
    var typingMessage: String
    var body: some View {
        HStack () {
            AvatarView(url: URL(string: TestData.DefaultProfile)!, presenceShown: false, size: 30)
            Text(typingMessage).font(.callout).frame(maxWidth: .infinity, alignment: .leading).padding(.leading)
        }.padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 10))
    }
}

#Preview {
    TypingIndicatorView(typingMessage: "Somebody typing")
}

