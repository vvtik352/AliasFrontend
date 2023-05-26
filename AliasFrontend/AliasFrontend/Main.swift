//
//  Main.swift
//  AliasFrontend
//
//  Created by 1234 on 17.05.2023.
//

import Foundation
import SwiftUI


// Main view with base functions.
struct Main: View {
    
    // View Model.
    @EnvironmentObject var dataManager: DataManager
    @State private var navigate = false
    @Binding var isTabViewHidden: Bool

    var body: some View {
            ZStack {
                // Set background.
                Rectangle()
                    .foregroundStyle(.linearGradient(colors: [.black, .mint], startPoint: .top, endPoint: .bottomTrailing))
                    .ignoresSafeArea()
                VStack {
                    // Button to create room.
                    NavigationLink(destination: RoomSettings().environmentObject(dataManager)) {
                        // Button view.
                        ZStack {
                            RoundedRectangle(cornerRadius: 30, style: .continuous)
                                .frame(width: 200, height: 70)
                                .foregroundColor(Color.mint)
                            Text("Create new room")
                                .foregroundColor(.white)
                                .font(.system(size:20, weight:.bold, design: .rounded))
                        }
                    }
                    // Button to join via invitation code.
                    NavigationLink(destination: RoomView(isTabViewHidden: $isTabViewHidden).environmentObject(dataManager)) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 30, style: .continuous)
                                .frame(width: 200, height: 70)
                                .foregroundColor(Color.mint)
                            Text("Join via code")
                                .foregroundColor(.white)
                                .font(.system(size:20, weight:.bold, design: .rounded))
                        }
                    }
                    // Button for logout.
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
            .navigationTitle($dataManager.userId)
            .navigationBarTitleTextColor(Color.mint.opacity(0.7))
            .foregroundColor(.white)
            .font(.system(size:20, weight:.bold, design: .rounded))
            .accentColor(Color(.systemGray4))
    }
}

//struct Main_Previews:  PreviewProvider {
//    static var previews: some View {
//        Main(isTabViewHidden: false)
//    }
//

