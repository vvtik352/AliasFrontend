//
//  RoomList.swift
//  AliasFrontend
//
//  Created by 1234 on 19.05.2023.
//

import Foundation
import SwiftUI

struct RoomList: View {
    @EnvironmentObject var dataManager: DataManager

    var body: some View {
        NavigationView {
            List(dataManager.gameRooms) { gameRoom in
                      VStack(alignment: .leading) {
                          Text(gameRoom.name)
//                          Text("Admin: \(gameRoom.admin)")
                          if let code = gameRoom.invitationCode {
                              Text("Invitation Code: \(code)")
                          }
                      }
                  }
                  .onAppear {
                      dataManager.getRooms()
                  }
        }
    }
}
