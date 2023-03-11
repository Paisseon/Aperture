//
//  Cache.swift
//  Aperture
//
//  Created by Lilliana on 10/03/2023.
//

import Combine

final class Cache: ObservableObject {
    static var shared: Cache = .init()
    
    @Published var messages: [Message] = []
    @Published var longText: String = ""
    
    private init() {}
}
