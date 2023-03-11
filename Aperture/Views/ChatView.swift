//
//  ChatView.swift
//  Aperture
//
//  Created by Lilliana on 10/03/2023.
//

import SwiftUI

struct ChatView: View {
    // MARK: Internal

    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        ForEach(messages, id: \.id) { message in
                            MessageView(message: message)
                                .id(message.id)
                        }
                    }
                    .onChange(of: messages.count) { _ in
                        proxy.scrollTo(messages.last?.id, anchor: .bottom)
                    }
                }
            }

            if isShowPrefs {
                ChatPrefsView(
                    temperature: $temperature,
                    maxTokens: $maxTokens,
                    topProbability: $topProbability,
                    presencePenalty: $presencePenalty,
                    frequencyPenalty: $frequencyPenalty,
                    skipModCheck: $skipModCheck
                )
            }

            Button(action: { isShowPrefs.toggle() }) {
                Image(systemName: isShowPrefs ? "chevron.down" : "chevron.up")
            }
            .buttonStyle(.plain)
            .padding(.top)

            PromptTextFieldView(prompt: $prompt, isLoading: $isLoading, messages: $messages, sendFunc: send)
        }
        .padding()
        .onDisappear {
            Cache.shared.messages = messages
        }
    }

    // MARK: Private

    // Configurations

    @State private var temperature: Double = 0.5
    @State private var maxTokens: Double = 0x800
    @State private var topProbability: Double = 1.0
    @State private var presencePenalty: Double = 0
    @State private var frequencyPenalty: Double = 0
    @State private var skipModCheck: Bool = true

    // States of being

    @State private var isLoading: Bool = false
    @State private var isShowPrefs: Bool = false
    @State private var prompt: String = ""
    @State private var messages: [Message] = Cache.shared.messages

    private func makeMessages() -> [GPTQuery.GPTMessage] {
        var ret: [GPTQuery.GPTMessage] = []

        for message: Message in messages.filter({ !$0.content.hasPrefix("[Error]") }) {
            ret.append(GPTQuery.GPTMessage(role: message.sender, content: message.content))
        }

        return ret
    }

    private func send() {
        guard !prompt.isEmpty else {
            return
        }
        
        Task(priority: .userInitiated) {
            await sendAsync()
        }
    }

    private func sendAsync() async {
        messages.append(Message(content: prompt, sender: .user))
        messages.append(Message(content: "", sender: .assistant))

        isLoading = true

        let query: GPTQuery = .init(
            model: .turbo,
            messages: makeMessages(),
            maxTokens: Int(maxTokens),
            temperature: temperature,
            topProbability: topProbability,
            isStream: true,
            presencePenalty: presencePenalty,
            frequencyPenalty: frequencyPenalty
        )

        do {
            if !skipModCheck {
                guard await Security.isSafe(prompt) else {
                    throw OpenAIError.censored
                }
            }

            let request: Request<GPTQuery, GPTResult> = .init(withBody: query, for: .gpt)
            
            try await request.sendStream() { val in
                if !messages.isEmpty {
                    messages[messages.count - 1].content += val.choices.last?.delta.content ?? ""
                }
            }
        } catch {
            messages.removeLast()
            let content: String

            if let oaiError: OpenAIError = error as? OpenAIError {
                content = oaiError.description
            } else {
                content = error.localizedDescription
            }

            messages.append(Message(content: "[Error] " + content + " Please try again.", sender: .system))
        }

        prompt = ""
        isLoading = false
    }
}
