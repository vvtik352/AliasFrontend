//
//  GameRoom.swift
//  AliasFrontend
//
//  Created by Vladimir on 21.05.2023.
//

import Foundation

struct GameRoom: Codable {
    let invitationCode: String
    let admin: User
    let id: String
    let pointsPerWord: Int
    let creator: User
    let isPrivate: Bool
    let name: String
    
    struct User: Codable {
        let id: String
    }
}
