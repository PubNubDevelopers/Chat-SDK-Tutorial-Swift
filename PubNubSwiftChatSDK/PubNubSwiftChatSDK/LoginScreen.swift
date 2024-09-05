//
//  LoginScreen.swift
//  PubNubSwiftChatSDK
//
//  Created by Darryn Campbell on 03/09/2024.
//

import SwiftUI

struct LoginScreen: View {
    @State var username: String
    var function: (_ username: String) -> Void
    var body: some View {
        VStack (alignment: .center) {
            Spacer()
            Image("chat-logo2")
                .resizable().scaledToFit()
                .frame(width: 100, height: 100).padding()
            Text("Log in: Sample Chat App").font(.title).bold().padding()
            Text("Built with the PubNub Chat SDK for Swift").font(.title2).padding([.vertical], 1).padding([.horizontal], 10).multilineTextAlignment(.center)
            TextField(
                "Choose a User ID",
                text: $username
            )
            .font(.body)
            .padding()
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .border(.secondary).padding([.vertical])
            Button("Log in",
                   action: {
                self.function(username)
            })
            .padding()
            .frame(maxWidth: .infinity)
            .background(Navy900)
            .foregroundStyle(.white)
            .cornerRadius(10)
            Spacer()
        }.padding()
        
    }
}

#Preview {
    LoginScreen(username: "Darryn 1", function: {username in })
}
