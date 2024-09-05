//
//  Avatar.swift
//  PubNubSwiftChatSDK
//
//  Created by Darryn Campbell on 03/09/2024.
//

import SwiftUI

struct AvatarView : View {
    let url: URL
    let presenceColor: Color
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
                    .stroke(Color.white, lineWidth: 4)
                    .frame(width: size, height: size)
            )
            Circle()
                .strokeBorder(Color.white,lineWidth: 1)
                .background(Circle().foregroundColor(presenceColor))
                .frame(width: size/4, height: size/4)
                .offset(x: -size/10, y: -size/10)
            //.shadow(radius: 10)
        }
    }
}


#Preview {
    VStack {
        AvatarView(url: URL(string: "https://chat-sdk-demo-web.netlify.app/avatars/placeholder2.png")!, presenceColor: Color.green, size: 100)

        AvatarView(url: URL(string: "https://chat-sdk-demo-web.netlify.app/avatars/placeholder2.png")!, presenceColor: Color.green, size: 50)
        
        AvatarView(url: URL(string: "https://chat-sdk-demo-web.netlify.app/avatars/placeholder2.png")!, presenceColor: Color.gray, size: 100)

        AvatarView(url: URL(string: "https://chat-sdk-demo-web.netlify.app/avatars/placeholder2.png")!, presenceColor: Color.gray, size: 50)
    }
}
