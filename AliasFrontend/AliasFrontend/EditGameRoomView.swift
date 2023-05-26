//
//  EditGameRoomView.swift
//  AliasFrontend
//
//  Created by Vladimir on 25.05.2023.
//

import Foundation
import SwiftUI

struct EditGameRoomView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var name: String = ""
    @State private var isPrivate: Bool = false
    @State private var pointsPerWord: Int = 0

    var body: some View {
        VStack {
            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Toggle(isOn: $isPrivate) {
                Text("Is Private?")
            }
            .padding()

            HStack {
                Text("Points per word:")
                Spacer()
                Stepper(value: $pointsPerWord, in: 0...10) {
                    Text("\(pointsPerWord)")
                }
            }
            .padding()

            Button(action: {
                // Passing nil for any value that hasn't been set
                dataManager.updateGameRoom(name: name.isEmpty ? nil : name, isPrivate: isPrivate, pointsPerWord: pointsPerWord)
            }) {
                Text("Update Game Room")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()
        }
    }
}
