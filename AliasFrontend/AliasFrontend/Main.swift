//
//  Main.swift
//  AliasFrontend
//
//  Created by 1234 on 17.05.2023.
//

import Foundation
import SwiftUI

struct Main: View {
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .foregroundStyle(.linearGradient(colors: [.black, .mint], startPoint: .top, endPoint: .bottomTrailing))
                    .ignoresSafeArea()
                VStack {
                    NavigationLink(destination: RoomSettings()) {
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 30, style: .continuous)
                                .frame(width: 200, height: 70)
                                .foregroundColor(Color.mint)
                            Text("Create new room")
                                .foregroundColor(.white)
                                .font(.system(size:20, weight:.bold, design: .rounded))
                        }
                    }
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
