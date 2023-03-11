//
//  GPTResult.swift
//  Aperture
//
//  Created by Lilliana on 09/03/2023.
//

struct GPTResult: Decodable {
    struct GPTChoice: Decodable {
        let index: Int
        let delta: GPTMessage
    }
    
    struct GPTMessage: Decodable {
        let content: String
    }

    let id: String
    let object: String
    let created: Int
    let choices: [GPTChoice]
}
