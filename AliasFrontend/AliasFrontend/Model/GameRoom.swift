//
//  GameRoom.swift
//  AliasFrontend
//
//  Created by Vladimir on 21.05.2023.
//

import Foundation

struct GameRoom: Identifiable, Decodable {
    var id: UUID
    var name: String
    var creator: String
    var isPrivate: Bool
    var invitationCode: String?
    var admin: String

    enum CodingKeys: String, CodingKey {
        case id, name, creator, isPrivate, invitationCode, admin
    }
}
