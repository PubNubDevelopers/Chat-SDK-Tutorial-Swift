//
//  NavIcon.swift
//  PubNubSwiftChatSDK
//
//  Created by Darryn Campbell on 05/09/2024.
//

import SwiftUI

struct NavIcon : View {
    let label: String
    let image: String
    let isHighlighted: Bool
    let clickAction: () -> Void
    var body: some View {
        VStack(spacing: 5) {
            Image(image)
                .resizable().scaledToFit()
                .frame(width: 30, height: 30)
            Text(label).font(.caption).foregroundStyle(.black)
            if (isHighlighted)
            {
                Divider().tint(Navy500)
            }
        }.contentShape(Rectangle())
            .onTapGesture {
                clickAction()
            }.frame(maxWidth: 55, maxHeight: 64).padding([.vertical], 5 ).padding([.horizontal]).background(Navy50)
    
    }
}


#Preview {
    VStack {
        NavIcon(label: "Home", image: "home", isHighlighted: true, clickAction: {})
        NavIcon(label: "People", image: "people_outline", isHighlighted: false, clickAction: {})
        NavIcon(label: "Mentions", image: "alternate_email", isHighlighted: false, clickAction: {})
        NavIcon(label: "Profile", image: "person", isHighlighted: false, clickAction: {})

    }
}

