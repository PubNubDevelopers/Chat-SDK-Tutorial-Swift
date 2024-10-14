//
//  MessageReadReceipt.swift
//  PubNubSwiftChatSDK
//
//  Created by Darryn Campbell on 08/09/2024.
//

import SwiftUI

struct MessageReadReceipt : View {
    var isRead : Bool
    var body: some View {
        if (isRead)
        {
            Image("read")
                .resizable().scaledToFit()
                .frame(width: 20, height: 20)
        }
        else
        {
            Image("sent")
                .resizable().scaledToFit()
                .frame(width: 20, height: 20)
        }
    }
}


#Preview {
    HStack (spacing:5) {
        MessageReadReceipt(isRead: false)
        MessageReadReceipt(isRead: true)

    }
}
