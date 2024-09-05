//
//  ContentView.swift
//  PubNubSwiftChatSDK
//
//  Created by Darryn Campbell on 03/09/2024.
//

import SwiftUI

struct ContentView: View {
    var myvar: Bool = false
    @State var loginScreenVisible: Bool = true
    @State var userId = ""
    var body: some View {
        if (loginScreenVisible)
        {
            LoginScreen(username: "", function: {username in self.login(username: username)})
        }
        else
        {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                if (myvar)
                {
                    Text("Hello, world!")
                }
                AvatarView(url: URL(string: "https://chat-sdk-demo-web.netlify.app/avatars/placeholder2.png")!, presenceColor: Color.green, size: 100)
                Button("Log in",
                       action: {
                    print("logging in")
                })
            }        .padding()
            
        }
        
    }
    func login(username: String) {
        print("Logging in " + username)
        if (!username.isEmpty)
        {
            loginScreenVisible = false
        }
    }
}

#Preview {
    ContentView()
}
