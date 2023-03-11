//
//  GPTQuery.swift
//  Aperture
//
//  Created by Lilliana on 09/03/2023.
//

struct GPTQuery: Encodable {
    enum CodingKeys: String, CodingKey {
        case model
        case messages
        case temperature
        case isStream = "stream"
        case maxTokens = "max_tokens"
        case frequencyPenalty = "frequency_penalty"
        case presencePenalty = "presence_penalty"
        case topProbability = "top_p"
    }

    struct GPTMessage: Encodable {
        let role: Role
        let content: String
    }

    let model: Model
    let messages: [GPTMessage]
    let maxTokens: Int // Varies by model
    let temperature: Double // 0.0 - 2.0
    let topProbability: Double // 0.0 - 1.0
    let isStream: Bool
    let presencePenalty: Double // -2.0 - 2.0
    let frequencyPenalty: Double // -2.0 - 2.0
}
