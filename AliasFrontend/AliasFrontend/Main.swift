//
//  Main.swift
//  AliasFrontend
//
//  Created by 1234 on 17.05.2023.
//

import Foundation
import SwiftUI

struct Main: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var navigate = false

    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .foregroundStyle(.linearGradient(colors: [.black, .mint], startPoint: .top, endPoint: .bottomTrailing))
                    .ignoresSafeArea()
                VStack {
                    NavigationLink(destination: RoomSettings().environmentObject(dataManager)) {
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 30, style: .continuous)
                                .frame(width: 200, height: 70)
                                .foregroundColor(Color.mint)
                            Text("Create new room")
                                .foregroundColor(.white)
                                .font(.system(size:20, weight:.bold, design: .rounded))
                        }
                    }
                    NavigationLink(value: "") {
                        ZStack {
                            RoundedRectangle(cornerRadius: 30, style: .continuous)
                                .frame(width: 200, height: 70)
                                .foregroundColor(Color.mint)
                            Text("Join via code")
                                .foregroundColor(.white)
                                .font(.system(size:20, weight:.bold, design: .rounded))
                        }
                    }
                    Button(action: {
                                    dataManager.logout()
                                    navigate = true
                                }) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                                            .frame(width: 200, height: 70)
                                            .foregroundColor(Color.mint)
                                        Text("Logout")
                                            .foregroundColor(.white)
                                            .font(.system(size:20, weight:.bold, design: .rounded))
                                    }
                                }
                                .background(
                                    NavigationLink(destination: StartPage(), isActive: $navigate) {
                                        EmptyView()
                                    }
                                )
                }
            }
        }
        .accentColor(Color(.systemGray4))
    }
}

struct Main_Previews:  PreviewProvider {
    static var previews: some View {
        Main()
    }
    
}
