import Foundation

// View Model.
class DataManager: ObservableObject {
    
    // User data.
    @Published var userCredentials: UserCredentials = UserCredentials(name: "", email: "", password: "")
    // Shows if user logged in.
    @Published var isLoggedIn = false
    // User token in the system.
    @Published var token = ""
    // User id.
    @Published var userId = ""
    // List of rooms.
    @Published var gameRooms: [GameRoom.WithStringIds] = []
    // Room that user in.
    @Published var currentRoom: GameRoom?

    // Creates post request.
    private func createPostRequest(urlString: String, parameters: [String: Any]) -> URLRequest? {
        // Check url.
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return nil
        }

        // Create request.
        var request = URLRequest(url: url)
        
        // Settings.
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
    
    // Creates get request.
    private func createGetRequest(urlString: String) -> URLRequest? {
        
        // Check url.
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return nil
        }

        // Create request.
        var request = URLRequest(url: url)
        
        // Settings.
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        return request
    }

    // Sending request.
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

    
    // Register user.
    func registerUser() {
        
        // Create request with parameters,
        guard let request = createPostRequest(urlString: "http://localhost:8080/users/register", parameters: ["name": userCredentials.name, "email": userCredentials.email, "password": userCredentials.password]) else {
            return
        }
        
        // Send request.
        sendRequest(request) { [weak self] _ in
            self?.isLoggedIn = true
            self?.loginUser()
        }
    }

    // Login user.
    func loginUser() {
        
        // Create request with parameters.
        guard let request = createPostRequest(urlString: "http://localhost:8080/users/login", parameters: ["email": userCredentials.email, "password": userCredentials.password]) else {
            return
        }
        
        // Send request,
        sendRequest(request) { [weak self] data in
            do {
                let tokenResponse = try JSONDecoder().decode(TokenResponse.self, from: data)
                DispatchQueue.main.async {
                    print("JOPAA", tokenResponse)
                    self?.getProfile()
                    self?.token = tokenResponse.value
                    self?.userId = tokenResponse.user.id
                    self?.isLoggedIn = true
                }
            } catch {
                print("Error decoding token: \(error)")
            }
        }
    }

    
    // User logout.
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
    
    // Function for getting user data.
    func getProfile() {
        guard let request = createGetRequest(urlString: "http://localhost:8080/users/profile") else {
            return
        }
        sendRequest(request) { [weak self] data in
            do {
                let user = try JSONDecoder().decode(String.self, from: data)
                DispatchQueue.main.async {
                    self?.userId = user
                }
            } catch {
                print("Error decoding getPofile: \(error)")
            }
        }
    }

    // Function for creating game room.
    func createGameRoom(gameRoomCreate: GameRoomCreate) {
        guard let request = createPostRequest(urlString: "http://localhost:8080/game-rooms/create", parameters: ["name": gameRoomCreate.name, "isPrivate": gameRoomCreate.isPrivate]) else {
            return
        }
        sendRequest(request) { [weak self] data in
            do{
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                    print("CHTO TOOT: ",json)
                } catch {
                    print("errorMsg")
                }
                let roomRes = try JSONDecoder().decode(GameRoom.self, from: data)
                self?.currentRoom = roomRes
                
                print("Game room successfully created.", roomRes)
            } catch{
                print("Error decoding token: \(error)")

            }
        }
    }

    // Deleting game room.
    func deleteRoom() {
        guard let request = createPostRequest(urlString: "http://localhost:8080/game-rooms/close-room", parameters: ["gameRoomId": currentRoom?.id]) else {
            return
        }
        sendRequest(request) { [weak self] data in
            do{
                self?.currentRoom = nil
                print("Game room successfully deleted.")
            } catch{
                print("Error decoding token: \(error)")

            }
        }
    }

    // Getting list of rooms.
    func getRooms() {
        guard let request = createGetRequest(urlString: "http://localhost:8080/game-rooms/list-all") else {
            return
        }
        sendRequest(request) { [weak self] data in
            do {
                let rooms = try JSONDecoder().decode([GameRoom.WithStringIds].self, from: data)
                DispatchQueue.main.async {
                    self?.gameRooms = rooms
                }
            } catch {
                print("Error decoding GameRooms: \(error)")
            }
        }
    }
    
    // Setting new parameters of game room.
    func updateGameRoom(name: String?, isPrivate: Bool?, pointsPerWord: Int?) {
        var parameters: [String: Any] = ["gameRoomId": currentRoom?.id]
        if let name = name {
            parameters["name"] = name
        }
        if let isPrivate = isPrivate {
            parameters["isPrivate"] = isPrivate
        }
        if let pointsPerWord = pointsPerWord {
            parameters["points"] = pointsPerWord
        }

        guard let request = createPostRequest(urlString: "http://localhost:8080/game-rooms/change-setting", parameters: parameters) else {
            return
        }
        sendRequest(request) { [weak self] data in
            do {

//                do {
//                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
//                    print("print data: ",json)
//                } catch {
//                    print("errorMsg")
//                }
                let updatedRoom = try JSONDecoder().decode(GameRoom.Update.self, from: data)
                DispatchQueue.main.async {
//                      self?.currentRoom = updatedRoom
                    self?.currentRoom?.name = updatedRoom.name
//                    self?.currentRoom?.pointsPerWord = updatedRoom.points
                    self?.currentRoom?.isPrivate = updatedRoom.isPrivate
                    print("Game room successfully updated.")
                }
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let error {
                print("Error decoding JSON: ", error)
            }
        }
    }
    
    // Adding user to the game room.
    func joinRoom(invitationCode: String?) {
          let parameters: [String: Any] = ["gameRoomId": currentRoom?.id]
          guard let request = createPostRequest(urlString: "http://localhost:8080/game-rooms/join-room", parameters: parameters) else {
              return
          }
          sendRequest(request) { _ in
              print("Successfully joined the game room.")
          }
      }
    
    
    // Deleting user from game room. 
    func kickParticipant(userIdToKick: UUID) {
        let parameters: [String: Any] = ["gameRoomId": currentRoom?.id, "userIdToKick": userIdToKick.uuidString]
            guard let request = createPostRequest(urlString: "http://localhost:8080/game-rooms/kick-participant", parameters: parameters) else {
                return
            }
            sendRequest(request) { _ in
                print("Participant successfully kicked.")
            }
        }

}
