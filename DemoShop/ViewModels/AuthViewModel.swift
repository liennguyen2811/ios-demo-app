import Foundation
import Combine

class AuthViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var errorMessage = ""
    @Published var isLoggedIn = false

    func login() {
        errorMessage = ""
        do {
            try AuthService.login(username: username, password: password)
            isLoggedIn = true
        } catch AuthError.emptyFields {
            errorMessage = "Username and password are required."
        } catch AuthError.lockedOut {
            errorMessage = "Sorry, this user has been locked out."
        } catch {
            errorMessage = "Username and password do not match any user in this service."
        }
    }

    func logout() {
        username = ""
        password = ""
        errorMessage = ""
        isLoggedIn = false
    }
}
