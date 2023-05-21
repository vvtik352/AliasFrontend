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
        }
        
    }
}

struct TabBarView_Previews:  PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
    
}
