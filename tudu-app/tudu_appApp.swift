//
//  tudu_appApp.swift
//  tudu-app
//
//  Created by Do Tran on 25/2/25.
//

import SwiftUI
import Clerk
import ConvexMobile

let convex = ConvexClient(deploymentUrl: "https://patient-axolotl-741.convex.cloud")

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
                if let publishableKey = Bundle.main.object(forInfoDictionaryKey: "ClerkPublishableKey") as? String {
                                    clerk.configure(publishableKey: publishableKey)
                                    try? await clerk.load()
                } else {
                    fatalError("Error: Could not load ClerkPublishableKey from Info.plist")
                }
                
            }
        }
    }
}
