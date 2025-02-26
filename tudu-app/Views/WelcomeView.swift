//
//  WelcomeView.swift
//  tudu-app
//
//  Created by Do Tran on 25/2/25.
//

import SwiftUI

struct WelcomeView: View {
    enum Destination: Hashable {
            case register
            case login
    }
    
    @State private var navigationPath = [Destination]()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                Text("Welcome to UpTodo")
                    .latoBoldFont(size: FontSizes.h1)
                    .padding(.top, Spacing.extraLarge)
                
                Text("Please login to your account or create new account to continue")
                    .latoFont(size: FontSizes.h3)
                    .padding(.top, Spacing.small)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                VStack {
                    TButton(title: "Login", isPrimary: true) {
                        //
                    }
                    
                    NavigationLink(destination: RegisterView()) {
                        TButton(title: "CREATE ACCOUNT", isPrimary: false, action: {
                            navigationPath.append(.register)
                        })
                    }
                    .padding(.top, Spacing.medium)
                }
                .padding(.bottom, Spacing.extraLarge)
            }
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .register:
                    RegisterView()
                        .navigationTitle("Register")
                case .login:
                    Text("Login view")
                }
            }
            
        }
        .padding()
    }
}

#Preview {
    WelcomeView()
}
