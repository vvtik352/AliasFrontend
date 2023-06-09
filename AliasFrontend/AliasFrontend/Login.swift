//
//  Login.swift
//  AliasFrontend
//
//  Created by 1234 on 12.05.2023.
//

import Foundation
import SwiftUI

// View for login.
struct Login: View {
    
    // Model View.
    @StateObject var dataManager = DataManager()
    
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
                        .placeholder(when: dataManager.userCredentials.name.isEmpty) {
                                                Text("Login")
                                                    .foregroundColor(Color(.systemGray4))
                                                    .bold()
                                                    .padding(.leading)
                                            }

                    
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.white)
                    TextField("Email", text:  $dataManager.userCredentials.email)
                        .foregroundColor(Color.white)
                        .textFieldStyle(.plain)
                        .padding()
                        .bold()
                    // Change text.
                        .placeholder(when: dataManager.userCredentials.email.isEmpty) {
                                                Text("Email")
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
                    // Change text.
                        .placeholder(when: dataManager.userCredentials.password.isEmpty) {
                                                Text("Password")
                                                    .foregroundColor(Color(.systemGray4))
                                                    .bold()
                                                    .padding(.leading)
                                            }
                    
                    
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.white)
                    Button {
                        // Button action to login user.
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
                    // Open TabBarView if user logged in.
                    NavigationLink(destination: TabBarView().environmentObject(dataManager), isActive: $dataManager.isLoggedIn) {
                                     EmptyView()
                                 }
                    
                }
            }.accentColor(.black)
        }.accentColor(.black)
    }
}

// Extension for TextField.
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
