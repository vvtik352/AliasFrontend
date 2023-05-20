//
//  TabBarView.swift
//  AliasFrontend
//
//  Created by 1234 on 17.05.2023.
//

import Foundation
import SwiftUI


// Shows bottom tab bar.
struct TabBarView: View {
    var body: some View {
        TabView {
            Main()
                .tabItem{
                    Image(systemName: "house")
                    Text("Main")

                }
            RoomList()
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Rooms")
                }

//                .tabItem {
//                    Image(systemName: "sparkle.magnifyingglass")
//                    Text("Browse")
//                }
//
//                .tabItem {
//                    Image(systemName: "person.circle.fill")
//                    Text("Profile")
//                }
        
        }
        
    }
}

struct TabBarView_Previews:  PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
    
}
