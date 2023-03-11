//
//  Request.swift
//  Aperture
//
//  Created by Lilliana on 09/03/2023.
//

import Foundation

struct Request<T: Encodable, U: Decodable> {
    private let urlRequest: URLRequest
    
    init(
        withBody body: T,
        for endpoint: Endpoint
    ) {
        var tmp: URLRequest = .init(url: URL(string: endpoint.rawValue)!)
        
        tmp.httpMethod = "POST"
        tmp.httpBody = try? JSONEncoder().encode(body)
        
        tmp.setValue("Bearer \(Config.apiKey)", forHTTPHeaderField: "Authorization")
        tmp.setValue("application/json", forHTTPHeaderField: "content-type")
        
        urlRequest = tmp
    }
    
    func sendStream(
        updateHandler: (U) -> Void
    ) async throws {
        guard urlRequest.httpBody != nil else {
            throw OpenAIError.noRequest
        }
        
        let bytes: URLSession.AsyncBytes = try await URLSession.shared.bytes(for: urlRequest).0
        
        for try await line in bytes.lines {
            guard line != "data: [DONE]" else {
                return
            }
            
            if let data: Data = line.dropFirst(6).data(using: .utf8) {
                if let response: U = try? JSONDecoder().decode(U.self, from: data) {
                    updateHandler(response)
                } else if let error: ErrorResult = try? JSONDecoder().decode(ErrorResult.self, from: data) {
                    try handleError(error)
                }
            }
        }
    }
    
    func send() async throws -> U {
        guard urlRequest.httpBody != nil else {
            throw OpenAIError.noRequest
        }
        
        let data: Data = try await URLSession.shared.data(for: urlRequest).0
        
        if let response: U = try? JSONDecoder().decode(U.self, from: data) {
            return response
        }
        
        if let error: ErrorResult = try? JSONDecoder().decode(ErrorResult.self, from: data) {
            try handleError(error)
        }
        
        throw OpenAIError.badReply
    }
    
    private func handleError(
        _ errObj: ErrorResult
    ) throws -> Never {
        if errObj.error.code == "invalid_api_key" {
            throw OpenAIError.apiKey
        }
        
        if errObj.error.message.hasPrefix("This model's maximum context length") {
            throw OpenAIError.tooLong
        }
        
        switch errObj.error.type {
            case "server_error":
                throw OpenAIError.serverError
            case "tokens":
                throw OpenAIError.rateLimit
            case "invalid_request_error":
                throw OpenAIError.censored
            default:
                throw OpenAIError.badReply
        }
    }
}
