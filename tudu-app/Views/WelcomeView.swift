//
//  WelcomeView.swift
//  tudu-app
//
//  Created by Do Tran on 25/2/25.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
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
                
                TButton(title: "CREATE ACCOUNT", isPrimary: false) {
                    //
                }
                .padding(.top, Spacing.medium)
            }
            .padding(.bottom, Spacing.extraLarge)
        }
        .padding()
    }
}

#Preview {
    WelcomeView()
}
