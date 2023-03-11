//
//  EditQuery.swift
//  Aperture
//
//  Created by Lilliana on 09/03/2023.
//

struct EditQuery: Encodable {
    enum CodingKeys: String, CodingKey {
        case model
        case input
        case instruction
        case temperature
        case topProbability = "top_p"
    }

    let model: Model
    let input: String
    let instruction: String
    let temperature: Double // 0.0 - 2.0
    let topProbability: Double // 0.0 - 1.0
}
