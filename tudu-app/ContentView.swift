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
        if isOnboardingComplete {
            Text("Onboarding Completed")
        } else {
            OnboardingView(isOnboardingComplete: $isOnboardingComplete)
                .latoFont(size: 16)
        }
    }
}

#Preview {
    ContentView()
}
