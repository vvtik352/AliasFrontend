import Foundation

class DataManager: ObservableObject {
    @Published var userCredentials: UserCredentials = UserCredentials(name: "", email: "", password: "")
    @Published var isLoggedIn = false
    @Published var token = ""
    @Published var userID: String? = nil
    @Published var gameRooms: [GameRoom] = []

    private func createPostRequest(urlString: String, parameters: [String: Any]) -> URLRequest? {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
        return request
    }
    
    private func createGetRequest(urlString: String) -> URLRequest? {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        return request
    }

    private func sendRequest(_ request: URLRequest, onSuccess: @escaping (_ data: Data) -> Void) {
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
        guard let request = createPostRequest(urlString: "http://localhost:8080/users/register", parameters: ["name": userCredentials.name, "email": userCredentials.email, "password": userCredentials.password]) else {
            return
        }
        sendRequest(request) { [weak self] _ in
            self?.isLoggedIn = true
            self?.loginUser()
        }
    }

    func loginUser() {
        guard let request = createPostRequest(urlString: "http://localhost:8080/users/login", parameters: ["email": userCredentials.email, "password": userCredentials.password]) else {
            return
        }
        sendRequest(request) { [weak self] data in
            do {
                let tokenResponse = try JSONDecoder().decode(TokenResponse.self, from: data)
                DispatchQueue.main.async {
                    print("JOPAA", tokenResponse.value)
                    self?.token = tokenResponse.value
                    self?.isLoggedIn = true
                }
            } catch {
                print("Error decoding token: \(error)")
            }
        }
    }

    func logout() {
        guard let request = createPostRequest(urlString: "http://localhost:8080/users/logout", parameters: [:]) else {
            return
        }
        sendRequest(request) { [weak self] _ in
            DispatchQueue.main.async {
                self?.token = ""
                self?.isLoggedIn = false
            }
        }
    }

    func createGameRoom(gameRoomCreate: GameRoomCreate) {
        guard let request = createPostRequest(urlString: "http://localhost:8080/game-rooms/create", parameters: ["name": gameRoomCreate.name, "isPrivate": gameRoomCreate.isPrivate]) else {
            return
        }
        sendRequest(request) { _ in
            print("Game room successfully created.")
        }
    }

    func getRooms() {
        guard let request = createGetRequest(urlString: "http://localhost:8080/game-rooms/list-all") else {
            return
        }
        sendRequest(request) { [weak self] data in
            do {
                let rooms = try JSONDecoder().decode([GameRoom].self, from: data)
                DispatchQueue.main.async {
                    self?.gameRooms = rooms
                }
            } catch {
                print("Error decoding GameRooms: \(error)")
            }
        }
    }
}
