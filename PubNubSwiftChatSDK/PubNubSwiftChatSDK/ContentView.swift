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
            LoginScreen(username: "Darryn 1", loginFunction: {username in self.login(username: username)})
        }
        else
        {
            HomeScreen(logout: {self.logout()})
        }

        
    }
    func login(username: String) {
        if (!username.isEmpty)
        {
            let userId = convertToId(username: username)
            print("Logging in " + userId)
            loginScreenVisible = false
        }
    }
    
    func logout() {
        loginScreenVisible = true
    }
    
    func convertToId(username: String) -> String {
        let regex = try! NSRegularExpression(pattern: "[^a-zA-Z0-9]")
        let range = NSMakeRange(0, username.count)
        let modString = regex.stringByReplacingMatches(in: username, options: [], range: range, withTemplate: "-")
        return modString.lowercased()
    }
}

#Preview {
    ContentView()
}
