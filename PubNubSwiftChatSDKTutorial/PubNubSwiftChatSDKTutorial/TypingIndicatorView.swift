//
//  TypingIndicator.swift
//  PubNubSwiftChatSDK
//
//  Created by Darryn Campbell on 08/09/2024.
//

import SwiftUI

struct TypingIndicatorView: View {
    var body: some View {
        Text("Typing: User1, User2").font(.callout).frame(maxWidth: .infinity, alignment: .leading).padding(.leading)
    }
}

#Preview {
    TypingIndicatorView()
}

