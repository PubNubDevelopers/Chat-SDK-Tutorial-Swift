//
//  NavBar.swift
//  PubNubSwiftChatSDK
//
//  Created by Darryn Campbell on 05/09/2024.
//

import SwiftUI

struct NavBar : View {
    var logout: () -> Void
    var body: some View {
        VStack(spacing: 0){
            Divider().tint(Navy200)
            HStack() {
                NavIcon(label: "Home", image: "home", isHighlighted: true, clickAction: {})
                NavIcon(label: "People", image: "people_outlined", isHighlighted: false, clickAction: {})
                NavIcon(label: "Mentions", image: "alternate_email1", isHighlighted: false, clickAction: {})
                NavIcon(label: "Log Out", image: "logout", isHighlighted: false, clickAction: logout)
            }.frame(maxWidth: .infinity, alignment: .leading).background(Navy50)
        }
    }
}


#Preview {
    NavBar(logout: {})
}


