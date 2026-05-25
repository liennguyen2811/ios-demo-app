import Foundation

struct User {
    let username: String
    let password: String
    let isLocked: Bool
}

enum AuthError: Error {
    case invalidCredentials
    case lockedOut
    case emptyFields
}

struct AuthService {
    private static let users: [User] = [
        User(username: "standard_user",     password: "secret_sauce", isLocked: false),
        User(username: "locked_out_user",   password: "secret_sauce", isLocked: true),
        User(username: "problem_user",      password: "secret_sauce", isLocked: false),
    ]

    static func login(username: String, password: String) throws {
        guard !username.isEmpty, !password.isEmpty else { throw AuthError.emptyFields }
        guard let user = users.first(where: { $0.username == username && $0.password == password })
        else { throw AuthError.invalidCredentials }
        if user.isLocked { throw AuthError.lockedOut }
    }
}
