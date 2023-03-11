//
//  Endpoint.swift
//  Aperture
//
//  Created by Lilliana on 09/03/2023.
//

enum Endpoint: String {
    case completion = "https://api.openai.com/v1/completions"
    case edit = "https://api.openai.com/v1/edits"
    case gpt = "https://api.openai.com/v1/chat/completions"
    case image = "https://api.openai.com/v1/images/generations"
    case moderation = "https://api.openai.com/v1/moderations"
    case speechTranscribe = "https://api.openai.com/v1/audio/transcriptions"
    case speechTranslate = "https://api.openai.com/v1/audio/translation"
}
