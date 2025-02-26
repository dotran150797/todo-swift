//
//  LoginView.swift
//  tudu-app
//
//  Created by Do Tran on 26/2/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State var showingErrorAlert = false
    
    var body: some View {
        VStack(spacing: Spacing.large) {
            VStack {
                Text("Username")
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextField("Enter your Username", text: $viewModel.username)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 2)
                    )
            }
            
            VStack {
                Text("Password")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                SecureField("Enter your password", text: $viewModel.password)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 2)
                    )
                
            }
            
            
            TButton(title: "Login", isPrimary: true, isLoading: viewModel.isLoading, action: {
                Task {
                    try await viewModel.login()
                    showingErrorAlert = viewModel.loginError != nil
                }
            })
            .padding(.top, Spacing.extraLarge)
        }
        .padding()
        .alert(isPresented: $showingErrorAlert) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.loginError?.errorDescription ?? "An unknown error occurred"),
                dismissButton: .default(Text("OK")) {
                    viewModel.loginError = nil // Clear error after dismissal
                }
            )
        }
    }
}

#Preview {
    LoginView()
}
