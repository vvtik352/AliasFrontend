//
//  RoomView.swift
//  AliasFrontend
//
//  Created by 1234 on 19.05.2023.
//

import Foundation
import SwiftUI

struct RoomView: View {
    var body: some View {
        NavigationView {
            ZStack {
//                Rectangle()
//                    .foregroundColor(.black)
//                    .ignoresSafeArea()
                //название комнаты + настройки + удаление + выход
                // две команды по 4 человека
                // кнопка для запуска игры
            }
            .navigationTitle("Название комнаты")
            .navigationBarBackButtonHidden()
            .navigationBarItems(leading:  Button {
            } label: {
                Label("", systemImage: "trash")
                    .foregroundColor(Color(.systemGray4))
            }, trailing:  Button {
            } label: {
                Label("", systemImage: "gearshape")
                    .foregroundColor(Color(.systemGray4))
            })
        }
    }
}

struct RoomView_Previews: PreviewProvider {
    static var previews: some View {
        RoomView()
    }
}
