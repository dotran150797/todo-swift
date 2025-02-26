//
//  RegisterViewModel.swift
//  tudu-app
//
//  Created by Do Tran on 26/2/25.
//
import SwiftUI
import Clerk

// MARK: - Enums
enum RegisterError: Error {
    case invalidUsername
    case invalidPassword
    case passwordDoNotMatch
    case signUpFailed(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidPassword:
            return "Password must be at least 5 characters long"
        case .invalidUsername:
            return "Username must be at least 5 characters long"
        case .passwordDoNotMatch:
            return "Password does not match"
        case .signUpFailed(let error):
            return error.localizedDescription
        }
    }
}

@MainActor
final class RegisterViewModel: ObservableObject {
    // MARK: - Published properties
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var error: RegisterError?
    @Published var isLoading: Bool = false
    
    
    // MARK: - Methods
    func register() async throws {
        isLoading = true
        defer {
            isLoading = false
        }
        
        do {
            try vadilateInfo()
            try await SignUp.create(
                strategy: .standard(password: password, username: username)
            )
            error = nil
        } catch let registerError as RegisterError {
            self.error = registerError
        } catch {
            self.error = RegisterError.signUpFailed(error)
        }
    }
    
    private func vadilateInfo() throws {
        guard username.count >= 5 else {
            throw RegisterError.invalidUsername
        }
        
        guard password.count >= 8 else {
            throw RegisterError.invalidPassword
        }
        
        guard password == confirmPassword else {
            throw RegisterError.passwordDoNotMatch
        }
    }
}
