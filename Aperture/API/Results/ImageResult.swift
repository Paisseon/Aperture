//
//  ImageResult.swift
//  Aperture
//
//  Created by Lilliana on 09/03/2023.
//

struct ImageResult: Decodable {
    struct ImageURL: Decodable {
        let url: String
    }
    
    let created: Double
    let data: [ImageURL]
}
