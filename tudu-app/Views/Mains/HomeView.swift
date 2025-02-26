//
//  HomeView.swift
//  tudu-app
//
//  Created by Do Tran on 26/2/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image("check-list")
                    .padding(.top, Spacing.extraLarge)
                
                Text("What do you want to do today?")
                    .latoBoldFont(size: FontSizes.h1)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, Spacing.large)
                
                Text("Tap + to add your tasks")
                    .latoFont(size: FontSizes.h3)
                
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        //
                    }) {
                        Image(systemName: "line.3.horizontal.decrease")
                            .foregroundColor(.primary)
                    }
                }
            }
            .navigationBarTitle("Home", displayMode: .inline)
        }
    }
}

#Preview {
    HomeView()
}
