//
//  LoginViewModel.swift
//  tudu-app
//
//  Created by Do Tran on 26/2/25.
//
import SwiftUI
import Clerk

// MARK: - Enums
enum LoginError: Error {
    case invalidUsername
    case invalidPassword
    case loginFailed(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidPassword:
            return "Password must be at least 5 characters long"
        case .invalidUsername:
            return "Username must be at least 8 characters long"
        case .loginFailed(let error):
            return error.localizedDescription
        }
    }
}

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var loginError: LoginError?
    @Published var isLoading = false
    
    func login() async throws {
        self.isLoading = true
        defer {
            self.isLoading = false
        }
                
        do {
            try validateInfo()
            try await SignIn.create(
                strategy: .identifier(username, password: password)
            )

        } catch let loginError as LoginError {
            self.loginError = loginError
        } catch {
            self.loginError = LoginError.loginFailed(error)
        }
    }
    
    private func validateInfo() throws {
        guard username.count >= 5 else {
            throw LoginError.invalidUsername
        }
        
        guard password.count >= 8 else {
            throw LoginError.invalidPassword
        }
    }
}
