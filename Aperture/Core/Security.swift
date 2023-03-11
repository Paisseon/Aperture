//
//  Security.swift
//  Aperture
//
//  Created by Lilliana on 09/03/2023.
//

struct Security {
    static func xorEncrypt(
        _ input: String
    ) -> [UInt8] {
        .init(input.utf8).map { $0 ^ 0x69 }
    }

    static func xorDecrypt(
        _ input: [UInt8]
    ) -> String {
        .init(bytes: input.map { $0 ^ 0x69 }, encoding: .utf8) ?? ""
    }
    
    static func isSafe(
        _ input: String
    ) async -> Bool {
        let query: ModerationQuery = .init(input: input, model: .modLatest)
        
        do {
            let request: Request<ModerationQuery, ModerationResult> = .init(withBody: query, for: .moderation)
            let response: ModerationResult = try await request.send()
            
            return response.results.first?.flagged != true
        } catch {
            return true
        }
    }
}
