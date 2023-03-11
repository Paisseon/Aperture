//
//  EditResult.swift
//  Aperture
//
//  Created by Lilliana on 09/03/2023.
//

struct EditResult: Decodable {
    let object: String
    let created: Int
    let choices: [Choice]
}
