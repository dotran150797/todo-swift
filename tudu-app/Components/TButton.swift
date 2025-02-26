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
    let action: () -> Void?
    
    var body: some View {
        Button(title) {
            action()
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
            .latoBoldFont(size: FontSizes.body)
    }
}
