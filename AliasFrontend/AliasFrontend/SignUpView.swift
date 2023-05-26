//
//  Login.swift
//  AliasFrontend
//
//  Created by 1234 on 12.05.2023.
//

import Foundation
import SwiftUI

// View for sign up.
struct SignUpView: View {
    
    // View Model.
    @StateObject var dataManager = DataManager()

    
    var body: some View {
        ZStack {
            // Set background.
            Rectangle()
                .foregroundStyle(.linearGradient(colors: [.black, .mint], startPoint: .top, endPoint: .bottomTrailing))
                .ignoresSafeArea()
            // Interactive elements.
            VStack(spacing: 20) {
                
                // Text field for name.
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
                
                
                // Text field for email.
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
                
                // Text field for password.
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
                
                // Button to register.
                Button {
                    
                    // Button action.
                    dataManager.registerUser()
                } label: {
                    // Button view.
                    Text("Sign up")
                        .bold()
                        .frame(width:200, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.linearGradient(colors:[.mint, .blue ], startPoint:.top, endPoint: .bottomTrailing))
                        ).foregroundColor(.white)
                }
                
                
                // Navigate to TabBarView if user logged in.
                NavigationLink(destination: TabBarView().environmentObject(dataManager),
                               isActive: $dataManager.isLoggedIn) {
                                 EmptyView()
                             }
                
            }
        
        }
        // Change navigation back button color.
        .accentColor(Color(.systemGray4))
    }
        
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
