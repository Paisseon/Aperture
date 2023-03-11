//
//  OpenAIError.swift
//  Aperture
//
//  Created by Lilliana on 09/03/2023.
//

enum OpenAIError: Error {
    case apiKey
    case badReply
    case censored
    case noData
    case noRequest
    case rateLimit
    case serverError
    case tooLong
    
    var description: String {
        switch self {
            case .apiKey:
                return "API key is invalid (probably got banned)."
            case .badReply:
                return "Data did not conform to known response formats."
            case .censored:
                return "The Earth King has invited you to Lake Laogai."
            case .noData:
                return "No data was returned by the server."
            case .noRequest:
                return "Request body is nil."
            case .rateLimit:
                return "Rate limit exceeded."
            case .serverError:
                return "OpenAI's server fucked up."
            case .tooLong:
                return "Input tokens plus maximum tokens exceeds model limit."
        }
    }
}
