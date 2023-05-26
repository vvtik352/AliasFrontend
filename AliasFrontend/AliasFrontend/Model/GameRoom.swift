//
//  GameRoom.swift
//  AliasFrontend
//
//  Created by Vladimir on 21.05.2023.
//

import Foundation

struct GameRoom: Codable, Identifiable  {
       let invitationCode: String?
       let admin: User
       var id: String?
       var pointsPerWord: Int?
       let creator: User
       var isPrivate: Bool
       var name: String
        
    
       enum CodingKeys: String, CodingKey {
           case invitationCode
           case admin
           case id
           case pointsPerWord
           case creator
           case isPrivate
           case name
       }
    
    struct WithStringIds: Codable, Identifiable {
        let invitationCode: String?
        let admin: String
        let id: String?
        var pointsPerWord: Int?
        let creator: String
        var isPrivate: Bool
        var name: String
    }
    struct Update: Decodable {
//        let invitationCode: String?
//        let admin: User
//        let id: String?
//        var pointsPerWord: Int
//        let creator: User
        var isPrivate: Bool
        var name: String
    }
    
}
