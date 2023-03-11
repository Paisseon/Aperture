//
//  Message.swift
//  Aperture
//
//  Created by Lilliana on 09/03/2023.
//

import Foundation

struct Message {
    let id: UUID = .init()
    var content: String
    let sender: Role
}
