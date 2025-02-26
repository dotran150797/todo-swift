//
//  RegisterView.swift
//  tudu-app
//
//  Created by Do Tran on 25/2/25.
//

import SwiftUI

struct RegisterView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    var body: some View {
            VStack(spacing: Spacing.large) {
                VStack {
                    Text("Username")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Enter your Username", text: $username)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 2)
                        )
                }
                
                VStack {
                    Text("Password")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    SecureField("Enter your password", text: $username)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 2)
                        )
                    
                }
                
                VStack {
                    Text("Confirm Password")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    SecureField("Enter confirm password", text: $username)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 2)
                        )
                    
                }
                
                TButton(title: "Register", isPrimary: true) {
                        //
                }
                .padding(.top, Spacing.extraLarge)
            }
            .padding()
    }
}

#Preview {
    RegisterView()
}
