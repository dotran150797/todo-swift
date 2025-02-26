//
//  tudu_appApp.swift
//  tudu-app
//
//  Created by Do Tran on 25/2/25.
//

import SwiftUI
import Clerk

@main
struct tudu_appApp: App {
    private var clerk = Clerk.shared

    var body: some Scene {
        WindowGroup {
            ZStack {
                if clerk.isLoaded {
                    ContentView()
                } else {
                    ProgressView()
                }
            }
            .environment(clerk)
            .task {
                clerk.configure(publishableKey: "pk_test_Z29sZGVuLWRydW0tOTAuY2xlcmsuYWNjb3VudHMuZGV2JA")
                try? await clerk.load()
            }
        }
    }
}
