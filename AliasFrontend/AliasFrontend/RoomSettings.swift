//
//  NewRoom.swift
//  AliasFrontend
//
//  Created by 1234 on 17.05.2023.
//

import Foundation
import SwiftUI

struct RoomSettings: View {
    @ObservedObject var dataManager = DataManager()
    @State private var roomName = ""
    @State private var isPrivate = false
    @State var myText: String = "invitation code"
        private let pastboard = UIPasteboard.general
    var body: some View {
        ZStack {
        
            Rectangle()
                .foregroundColor(.black)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Text("Room settings")
                    .foregroundColor(.mint.opacity(0.7))
                    .font(.title)
                    .bold()
                    .padding(.bottom)
                TextField("Type room name", text: $roomName)
                    .foregroundColor(Color.white)
                    .textFieldStyle(.plain)
                    .padding()
                    .bold()
                    .placeholder(when: roomName.isEmpty) {
                                            Text("Type room name")
                                                .foregroundColor(Color(.systemGray4))
                                                .bold()
                                                .padding(.leading)
                                        }

                
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                Toggle("Private room", isOn: $isPrivate)
                    .foregroundColor(Color(.systemGray4))
                    .padding(.trailing)
                    .padding(.leading)
                    .toggleStyle(SwitchToggleStyle(tint: .mint))

                if isPrivate {
                    ZStack {
                        Rectangle()
                            .frame(width: 350, height: 30)
                            .foregroundColor(Color.gray.opacity(0.5))
                            .cornerRadius(10)
                        HStack {
                            Text(myText)
                                .foregroundColor(Color(.systemGray4))
                            Button {
                                pastboard.string = myText
                            } label: {
                                Label("", systemImage: "doc.on.doc")
                                    .foregroundColor(Color(.systemGray4))
                            }
                        }
                    }
                }
                Button {
                    let room = GameRoomCreate(name: self.roomName, isPrivate: self.isPrivate)
                    self.dataManager.createGameRoom(gameRoomCreate: room)
                } label: {
                    Text("Save!")
                        .bold()
                        .frame(width:200, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.linearGradient(colors:[.mint, .blue ], startPoint:.top, endPoint: .bottomTrailing))
                        ).foregroundColor(.white)
                }
                
            }
        }
    }
}

struct RoomSettings_Previews: PreviewProvider {
    static var previews: some View {
        RoomSettings()
    }
}
