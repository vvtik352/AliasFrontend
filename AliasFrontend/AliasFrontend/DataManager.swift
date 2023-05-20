//
//  SignUpViewModel.swift
//  AliasFrontend
//
//  Created by Vladimir on 19.05.2023.
//

import Foundation

class DataManager: ObservableObject {
    @Published var userCredentials: UserCredentials = UserCredentials(name: "", email: "", password: "")
    @Published var isLoggedIn = false
    @Published var token = ""
    @Published var userID: String? = nil

    private func sendRequest(urlString: String, onSuccess: @escaping (_ data: Data) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters: [String: Any] = ["name": userCredentials.name, "email": userCredentials.email, "password": userCredentials.password]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            return
        }

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("Error occurred: \(String(describing: error))")
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                DispatchQueue.main.async {
                    onSuccess(data)
                }
            } else {
                print("Error: \(String(describing: response))")
            }
        }
        

        task.resume()
    }
    
    func registerUser() {
        sendRequest(urlString: "http://localhost:8080/users/register") { [weak self] data in
            do {
                DispatchQueue.main.async {
                    self?.loginUser()
                    self?.isLoggedIn = true
                }
            } catch {
                print("Error decoding token: \(error)")
            }
        }
    }

    func loginUser() {
        sendRequest(urlString: "http://localhost:8080/users/login") { [weak self] data in
            do {
                let tokenResponse = try JSONDecoder().decode(TokenResponse.self, from: data)
                DispatchQueue.main.async {
                    print("JOPAA",tokenResponse.value)
                    self?.token = tokenResponse.value
                    self?.isLoggedIn = true
                }
            } catch {
                print("Error decoding token: \(error)")
            }
        }
    }
    
    func createGameRoom(gameRoomCreate: GameRoomCreate) {
        guard let url = URL(string: "http://localhost:8080/game-rooms/create") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(self.token)", forHTTPHeaderField: "Authorization")

        do {
            let jsonData = try JSONEncoder().encode(gameRoomCreate)
            request.httpBody = jsonData
        } catch let error {
            print(error.localizedDescription)
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error occurred: \(String(describing: error))")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("Game room successfully created.")
            } else {
                print("Error: \(String(describing: response))")
            }
        }

        task.resume()
    }

}
