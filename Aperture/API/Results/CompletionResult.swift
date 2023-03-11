//
//  CompletionResult.swift
//  Aperture
//
//  Created by Lilliana on 09/03/2023.
//

struct CompletionResult: Decodable {
    let id: String
    let object: String
    let created: Double
    let model: Model
    let choices: [Choice]
}
