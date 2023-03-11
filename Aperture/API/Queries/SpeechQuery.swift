//
//  SpeechQuery.swift
//  Aperture
//
//  Created by Lilliana on 09/03/2023.
//

struct SpeechQuery: Encodable {
    let model: String
    let file: String
    let language: String // 2-letter format
}
