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
    @Binding var isTabViewHidden: Bool

    var body: some View {
        NavigationView {
            List(dataManager.gameRooms) { gameRoom in
                NavigationLink(destination: RoomView(isTabViewHidden: $isTabViewHidden).environmentObject(dataManager).onAppear {
                    dataManager.currentRoom?.id = gameRoom.id
                    dataManager.currentRoom?.name = gameRoom.name
                    dataManager.currentRoom?.isPrivate = gameRoom.isPrivate
                    dataManager.currentRoom?.pointsPerWord = gameRoom.pointsPerWord
                }) {
                    VStack(alignment: .leading) {
                        Text(gameRoom.name)
                         Text("Admin: \(gameRoom.admin)")
                    }
                }
            }
            .onAppear {
                dataManager.getRooms()
            }
     
        }
    }
}
