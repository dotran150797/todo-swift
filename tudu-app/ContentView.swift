//
//  ContentView.swift
//  tudu-app
//
//  Created by Do Tran on 25/2/25.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isOnboardingComplete") private var isOnboardingComplete = false
    
    var body: some View {
        Group {
            if isOnboardingComplete {
                WelcomeView()
                    .transition(.move(edge: .trailing))
            } else {
                OnboardingView(isOnboardingComplete: $isOnboardingComplete)
                    .transition(.move(edge: .leading))
            }
        }
        .latoFont(size: 16)
        .animation(.easeInOut, value: isOnboardingComplete)
    }
}

#Preview {
    ContentView()
}
