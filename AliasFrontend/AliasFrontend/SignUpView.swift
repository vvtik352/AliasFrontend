//
//  Login.swift
//  AliasFrontend
//
//  Created by 1234 on 12.05.2023.
//

import Foundation
import SwiftUI


struct SignUpView: View {
    
    @StateObject var dataManager = DataManager()

    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var repeatPassword = ""
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.linearGradient(colors: [.black, .mint], startPoint: .top, endPoint: .bottomTrailing))
                .ignoresSafeArea()
            VStack(spacing: 20) {
                TextField("Name", text: $dataManager.userCredentials.name)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .padding()
                    .bold()
                    .placeholder(when: dataManager.userCredentials.name.isEmpty) {
                                            Text("Name")
                                                .foregroundColor(Color(.systemGray4))
                                                .bold()
                                                .padding(.leading)
                                        }

                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                
                TextField("Email", text: $dataManager.userCredentials.email)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .padding()
                    .bold()
                    .placeholder(when: dataManager.userCredentials.email.isEmpty) {
                                            Text("Email")
                                                .foregroundColor(Color(.systemGray4))
                                                .bold()
                                                .padding(.leading)
                                        }

                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                SecureField("Password", text: $dataManager.userCredentials.password)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .padding(.leading)
                    .bold()
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
                    dataManager.registerUser()
                } label: {
                    Text("Sign up")
                        .bold()
                        .frame(width:200, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.linearGradient(colors:[.mint, .blue ], startPoint:.top, endPoint: .bottomTrailing))
                        ).foregroundColor(.white)
                }
                
                NavigationLink(destination: TabBarView().environmentObject(dataManager),
                               isActive: $dataManager.isLoggedIn) {
                                 EmptyView()
                             }
                
            }
        }.accentColor(Color(.systemGray4))
    }
        
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
