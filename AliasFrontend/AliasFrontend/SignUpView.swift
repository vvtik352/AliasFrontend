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
    
    func registerUser() {
        // ensure that the password fields match
        guard password == repeatPassword else {
            // handle non-matching passwords
            print("Passwords don't match")
            return
        }

        // create the url with URL
        let url = URL(string: "http://localhost:8080/users/register")!

        // create the post request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // convert parameters to JSON and add to request body
        let parameters: [String: Any] = ["name": name, "password": password]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            return
        }

        // create dataTask using session object to send data to server
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in

            guard error == nil else {
                print("Error occurred: \(String(describing: error))")
                return
            }

            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
            }
        })

        task.resume()
    }
    
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
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                
                TextField("Email", text: $dataManager.userCredentials.email)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .padding()
                    .bold()
                
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                SecureField("Password", text: $dataManager.userCredentials.password)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .padding(.leading)
                    .bold()
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
