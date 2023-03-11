//
//  ChatPrefsView.swift
//  Aperture
//
//  Created by Lilliana on 11/03/2023.
//

import SwiftUI

struct ChatPrefsView: View {
    @Binding var temperature: Double
    @Binding var maxTokens: Double
    @Binding var topProbability: Double
    @Binding var presencePenalty: Double
    @Binding var frequencyPenalty: Double
    @Binding var skipModCheck: Bool

    var body: some View {
        VStack {
            Group {
                HStack {
                    Text("Accurate")
                    Spacer()
                    Text("Creative")
                }
                Slider(value: $temperature, in: 0 ... 1)

                Text("Allow \(Int(maxTokens))-token responses")
                Slider(value: $maxTokens, in: 0 ... 0xC00)

                Text("Consider top \(Int(topProbability * 100))% probability tokens")
                Slider(value: $topProbability, in: 0 ... 1)
            }
            
            Group {
                HStack {
                    Text("Focused")
                    Spacer()
                    Text("Adventurous")
                }
                Slider(value: $presencePenalty, in: -2 ... 2)
                
                HStack {
                    Text("Repetitive")
                    Spacer()
                    Text("David Byrne")
                }
                Slider(value: $frequencyPenalty, in: -2 ... 2)
                
                Toggle("Skip Moderation", isOn: $skipModCheck)
                    .padding()
            }
        }
        .padding()
        .background(
            Color.gray
                .opacity(0.3)
                .clipShape(RoundedRectangle(cornerRadius: 18))
        )
        .padding()
    }
}
