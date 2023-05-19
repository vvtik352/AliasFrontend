//
//  SignUpViewModel.swift
//  AliasFrontend
//
//  Created by Vladimir on 19.05.2023.
//

import Foundation

class SignUpViewModel: ObservableObject {
    @Published var userCredentials: UserCredentials = UserCredentials(name: "", email: "", password: "")

    func registerUser() {
        // ensure that the password fields match
        guard userCredentials.password == userCredentials.password else {
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
        let parameters: [String: Any] = ["name": userCredentials.name, "email": userCredentials.email, "password": userCredentials.password]
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
}
