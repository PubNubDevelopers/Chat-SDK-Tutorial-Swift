//
//  Avatar.swift
//  PubNubSwiftChatSDK
//
//  Created by Darryn Campbell on 03/09/2024.
//

import SwiftUI

struct AvatarView : View {
    let url: URL
    var presenceShown: Bool = true
    var presenceColor: Color = Color.black
    let size: CGFloat
    var body: some View {
        ZStack (alignment: .bottomTrailing) {
            AsyncImage(url: url){ image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Image(systemName: "photo.fill")
            }
            .frame(width: size, height: size)
            .cornerRadius(size / 2)
            .overlay(
                Circle()
                    .stroke(Color.white, lineWidth: 0)
                    .frame(width: size, height: size)
            )
            if (presenceShown)
            {
                Circle()
                    .strokeBorder(Color.white,lineWidth: 1)
                    .background(Circle().foregroundColor(presenceColor))
                    .frame(width: size/4, height: size/4)
                    .offset(x: -size/50, y: -size/50)
                //.shadow(radius: 10)
            }
        }
    }
}


#Preview {
    VStack {
        AvatarView(url: URL(string: "https://chat-sdk-demo-web.netlify.app/avatars/placeholder2.png")!, presenceShown: false, size: 100)

        AvatarView(url: URL(string: "https://chat-sdk-demo-web.netlify.app/avatars/placeholder2.png")!, presenceColor: StatusIndicatorSuccess, size: 100)

        AvatarView(url: URL(string: "https://chat-sdk-demo-web.netlify.app/avatars/placeholder2.png")!, presenceColor: StatusIndicatorSuccess, size: 50)
        
        AvatarView(url: URL(string: "https://chat-sdk-demo-web.netlify.app/avatars/placeholder2.png")!, presenceColor: Neutral300, size: 100)

        AvatarView(url: URL(string: "https://chat-sdk-demo-web.netlify.app/avatars/placeholder2.png")!, presenceColor: Neutral300, size: 50)
        
        AvatarView(url: URL(string: "https://chat-sdk-demo-web.netlify.app/avatars/m/63.jpg")!, presenceColor: Neutral300, size: 200)

    }
}
