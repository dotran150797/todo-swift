//
//  TButton.swift
//  tudu-app
//
//  Created by Do Tran on 25/2/25.
//

import SwiftUI

struct TButton: View {
    let title: String
    let isPrimary: Bool
    let isLoading: Bool
    let action: () -> Void?
    
    var body: some View {
        Button(action: {
            action()
        }) {
            HStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .tint(isPrimary ? .white : Color(hex: "#8875FF"))
                        .scaleEffect(0.8)
                }
                
                Text(title)
            }
        }
            .frame(maxWidth: .infinity)
            .padding()
            .background(isPrimary ? Color(hex: "#8875FF") : nil)
            .foregroundColor(isPrimary ? Color.white : Color.primary)
            .cornerRadius(15)
            .textCase(.uppercase)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(isPrimary ? Color.clear : Color(hex: "#8875FF"), lineWidth: 2)
            )
            .disabled(isLoading)
            .latoBoldFont(size: FontSizes.body)
    }
}
