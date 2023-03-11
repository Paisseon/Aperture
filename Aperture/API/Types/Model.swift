//
//  Model.swift
//  Aperture
//
//  Created by Lilliana on 09/03/2023.
//

enum Model: String, Codable {
    // Code
    
    case codex = "code-davinci-002"
    case codexEdit = "code-davinci-edit-001"
    
    // Edit
    
    case edit = "text-davinci-edit-001"
    
    // GPT
    
    case turbo = "gpt-3.5-turbo"
    
    // Moderation
    
    case modLatest = "text-moderation-latest"
    case modStable = "text-moderation-stable"
    
    // Speech
    
    case whisper = "whisper-1"
    
    // Text
    
    case daVinci3 = "text-davinci-003"
    case daVinci2 = "text-davinci-002"
}
