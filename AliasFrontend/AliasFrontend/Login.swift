//
//  Login.swift
//  AliasFrontend
//
//  Created by 1234 on 12.05.2023.
//

import Foundation
import SwiftUI


struct Login: View {
    @StateObject var dataManager = DataManager()

    @State private var name = ""
    @State private var password = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .foregroundStyle(.linearGradient(colors: [.black, .mint], startPoint: .top, endPoint: .bottomTrailing))
                    .ignoresSafeArea()
                VStack(spacing: 20) {
                    TextField("Login", text:  $dataManager.userCredentials.name)
                        .foregroundColor(Color.white)
                        .textFieldStyle(.plain)
                        .padding()
                        .bold()
                        .placeholder(when: name.isEmpty) {
                                                Text("Login")
                                                    .foregroundColor(Color(.systemGray4))
                                                    .bold()
                                                    .padding(.leading)
                                            }

                    
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.white)

                    SecureField("", text:  $dataManager.userCredentials.password)
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .padding(.leading)
                        .bold()
                        .placeholder(when: password.isEmpty) {
                                                Text("Password")
                                                    .foregroundColor(Color(.systemGray4))
                                                    .bold()
                                                    .padding(.leading)
                                            }
                    
                    
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.white)
                    Button {
                        dataManager.loginUser()
                    } label: {
                        Text("Login")
                            .bold()
                            .frame(width:200, height: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.linearGradient(colors:[.mint, .blue ], startPoint:.top, endPoint: .bottomTrailing))
                            ).foregroundColor(.white)
                    }
                    
                    NavigationLink(destination: TabBarView(), isActive: $dataManager.isLoggedIn) {
                                     EmptyView()
                                 }
                    
                }
            }.accentColor(.black)
        }.accentColor(.black)
    }
        
    
}
extension  View {
    func placeholder<Content: View> (
        when shuldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shuldShow ? 1: 0)
                self
            }
        }
}
struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
