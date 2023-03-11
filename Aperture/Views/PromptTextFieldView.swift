//
//  PromptTextFieldView.swift
//  Aperture
//
//  Created by Lilliana on 10/03/2023.
//

import SwiftUI

struct PromptTextFieldView: View {
    @Binding var prompt: String
    @Binding var isLoading: Bool
    @Binding var messages: [Message]
    
    let sendFunc: () -> Void
    
    var body: some View {
        HStack {
            Button(action: clear) {
                Image(systemName: "trash")
            }
            .padding([.top, .leading, .bottom])
            .disabled(messages.isEmpty)
            
            TextField("Type your prompt here", text: $prompt, onCommit: sendFunc)
                .background(Color.gray.opacity(0.15))
                .cornerRadius(18)
                .padding()
            
            Button(action: sendFunc) {
                Image(systemName: "paperplane")
            }
            .padding([.top, .trailing, .bottom])
            .disabled(prompt.isEmpty || isLoading)
        }
    }
    
    private func clear() {
        isLoading = false
        
        Task {
            await MainActor.run {
                messages = []
            }
        }
    }
}
