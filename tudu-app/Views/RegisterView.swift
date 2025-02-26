//
//  RegisterView.swift
//  tudu-app
//
//  Created by Do Tran on 25/2/25.
//

import SwiftUI
import Clerk

struct RegisterView: View {
    @StateObject private var viewModel: RegisterViewModel = RegisterViewModel()
    @State private var showingErrorAlert = false
    
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
                
                VStack {
                    Text("Confirm Password")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    SecureField("Enter confirm password", text: $viewModel.confirmPassword)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 2)
                        )
                    
                }
                
                TButton(title: "Register", isPrimary: true, isLoading: viewModel.isLoading, action: {
                    Task {
                        try await viewModel.register()
                        showingErrorAlert = viewModel.error != nil
                    }
                })
                .padding(.top, Spacing.extraLarge)
            }
            .padding()
            .alert(isPresented: $showingErrorAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.error?.errorDescription ?? "An unknown error occurred"),
                    dismissButton: .default(Text("OK")) {
                        viewModel.error = nil // Clear error after dismissal
                    }
                )
            }
    }
}

#Preview {
    RegisterView()
}
