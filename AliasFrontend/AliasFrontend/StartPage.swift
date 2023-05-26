//
//  StartPage.swift
//  AliasFrontend
//
//  Created by 1234 on 12.05.2023.
//

import Foundation
import SwiftUI

// Start page of the app.
struct StartPage: View {
    var body: some View {
        NavigationView {
            ZStack {
                // Add background.
                Rectangle()
                    .foregroundStyle(.linearGradient(colors: [.black, .mint], startPoint: .top, endPoint: .bottomTrailing))
                    .ignoresSafeArea()
                VStack {
                    // Buttons for login and sign up.
                    NavigationLink(destination: Login()) {
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 30, style: .continuous)
                                .frame(width: 200, height: 70)
                                .foregroundColor(Color.mint)
                            Text("Login")
                                .foregroundColor(.white)
                                .font(.system(size:20, weight:.bold, design: .rounded))
                        }
                    }
                    NavigationLink(destination: SignUpView()) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 30, style: .continuous)
                                .frame(width: 200, height: 70)
                                .foregroundColor(Color.black)
                            Text("Sign up")
                                .foregroundColor(.white)
                                .font(.system(size:20, weight:.bold, design: .rounded))
                        }
                    }
                }
            }

            // Change navigation back button.
        }.accentColor(Color(.systemGray4))
    }
}
struct StartPage_Previews: PreviewProvider {
    static var previews: some View {
        StartPage()
    }
}
