//
//  ContentView.swift
//  tudu-app
//
//  Created by Do Tran on 25/2/25.
//

import SwiftUI
import Clerk

struct ContentView: View {
    @Environment(Clerk.self) private var clerk
    @AppStorage("isOnboardingComplete") private var isOnboardingComplete = false
    
    
    var body: some View {
        Group {
            currentView
        }
        .latoFont(size: 16)
        .animation(.easeInOut, value: isOnboardingComplete)
    }
    
    @ViewBuilder
    private var currentView: some View {
        if isOnboardingComplete {
            if clerk.user == nil {
                WelcomeView()
                    .transition(.move(edge: .trailing))
            } else {
                Text("Home screen")
            }
        } else {
            OnboardingView(isOnboardingComplete: $isOnboardingComplete)
                .transition(.move(edge: .leading))
        }
    }
   
}

#Preview {
    ContentView()
}
