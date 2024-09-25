//
//  Header.swift
//  PubNubSwiftChatSDK
//
//  Created by Darryn Campbell on 05/09/2024.
//

import SwiftUI

struct HeaderView : View {
    let chatLayout: Bool
    var backFunction: () -> Void = {}
    var title: String = ""
    var avatarUrl: String = ""
    var body: some View {
        HStack() {
            if (!chatLayout)
            {
                ZStack() {
                    Circle()
                        .foregroundColor(Navy50)
                        .frame(width: 55, height: 55)
                        .offset(x: 0, y: 0).padding(8)
                    Image("pn_logo_red_tint")
                        .resizable().scaledToFit()
                        .frame(width: 30, height: 30).padding()
                }
                Text("PubNub").font(.headline).foregroundStyle(.white).padding()
                Spacer()
                Button {
                    print("Not Implemented")
                } label: {
                    Image("notifications_none")
                        .resizable().scaledToFit()
                        .frame(width: 30, height: 30).padding()
                }
            }
            else {
                //  Chat Layout
                Button {
                    backFunction()
                } label: {
                    Image("chevron_left")
                        .resizable().scaledToFit()
                        .frame(width: 35, height: 35).padding()
                }
                AvatarView(url: URL(string: avatarUrl)!, presenceColor: StatusIndicatorSuccess, size: 40)
                Text(title).font(.headline).foregroundStyle(.white).padding()
            }

        }.frame(maxWidth: .infinity, alignment: .leading).background(Navy900)
    }
}


#Preview {
    VStack {
        HeaderView(chatLayout: false)

        HeaderView(chatLayout: true, backFunction: {}, title: "Sarah Johannsen", avatarUrl: "https://chat-sdk-demo-web.netlify.app/avatars/placeholder2.png")

    }
}

