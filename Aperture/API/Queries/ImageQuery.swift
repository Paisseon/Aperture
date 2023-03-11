//
//  ImageQuery.swift
//  Aperture
//
//  Created by Lilliana on 09/03/2023.
//

struct ImageQuery: Encodable {
    let prompt: String
    let n: Int
    let size: ImageSize
}
