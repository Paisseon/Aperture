//
//  MessageView.swift
//  Aperture
//
//  Created by Lilliana on 10/03/2023.
//

import SwiftUI

struct MessageView: View {
    let message: Message
    
    var body: some View {
        HStack {
            if message.sender == .user {
                Spacer()
            }
            
            Text(message.content)
                .textSelection(.enabled)
                .padding()
                .background(bubbleColour)
                .cornerRadius(18)
                .padding([.leading, .trailing, .top])
            
            if message.sender == .assistant {
                Spacer()
            }
        }
    }
    
    private var bubbleColour: Color {
        switch message.sender {
            case .assistant:
                return .gray.opacity(0.3)
            case .system:
                return .clear
            case .user:
                return .accentColor
        }
    }
}
