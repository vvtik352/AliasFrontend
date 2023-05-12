//
//  Login.swift
//  AliasFrontend
//
//  Created by 1234 on 12.05.2023.
//

import Foundation
import SwiftUI


struct Login: View {
    @State private var login = ""
    @State private var password = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .foregroundStyle(.linearGradient(colors: [.black, .mint], startPoint: .top, endPoint: .bottomTrailing))
                    .ignoresSafeArea()
                VStack(spacing: 20) {
                    TextField("Login", text: $login)
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .padding()
                        .bold()
                    
                    
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.white)
                    SecureField("Password", text: $password)
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                    //                                    .placeholder(when: password.isEmpty) {
                    //                                        Text("Password")
                    //                                            .foregroundColor(.white)
                    //                                            .bold()
                    //                                    }
                        .padding(.leading)
                        .bold()
                    
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.white)
                    // add action
                    Button {
                    } label: {
                        Text("Login")
                            .bold()
                            .frame(width:200, height: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.linearGradient(colors:[.mint, .blue ], startPoint:.top, endPoint: .bottomTrailing))
                            ).foregroundColor(.white)
                    }
                    
                }
            }.accentColor(.black)
        }.accentColor(.black)
    }
        
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
