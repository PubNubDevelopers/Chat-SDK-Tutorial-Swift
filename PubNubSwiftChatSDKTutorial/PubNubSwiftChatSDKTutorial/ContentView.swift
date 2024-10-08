//
//  ContentView.swift
//  PubNubSwiftChatSDKTutorial
//
//  Created by Darryn Campbell on 25/09/2024.
//

import SwiftUI
import PubNubSDK
import PubNubSwiftChatSDK

struct ContentView: View {
    var myvar: Bool = false
    @State var loginScreenVisible: Bool = true
    @State var userId = ""
    @State var userName = ""
    var body: some View {
        if (loginScreenVisible)
        {
            LoginScreen(username: "", loginFunction: {username in self.login(username: username)})
        }
        else
        {
            HomeScreen(logout: {self.logout()}, userId: userId, username: userName, chat: nil)
        }
    }
    func login(username: String) {
        if (!username.isEmpty)
        {
            userName = username
            userId = convertToId(username: username)
            debugPrint("Logging in " + userId)
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
