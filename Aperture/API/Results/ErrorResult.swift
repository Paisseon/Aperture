//
//  ErrorResult.swift
//  Aperture
//
//  Created by Lilliana on 09/03/2023.
//

struct ErrorResult: Codable {
    struct ErrorResult: Codable {
        let message: String
        let type: String
        let param: String?
        let code: String?
    }

    let error: ErrorResult
}
