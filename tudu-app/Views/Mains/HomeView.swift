//
//  HomeView.swift
//  tudu-app
//
//  Created by Do Tran on 26/2/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel = HomeViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                // Base content: task list or empty view
                if viewModel.tasks.isEmpty {
                    emptyView
                } else {
                    List{
                        Section(header: Text("Today")) {
                            ForEach(viewModel.todayTasks) { todayTask in
                                TodoItem(viewModel: viewModel, todo: todayTask)
                            }
                        }
                        
                        Section(header: Text("Completed")) {
                            ForEach(viewModel.competedTasks) { completedTask in
                                TodoItem(viewModel: viewModel, todo: completedTask)
                            }
                        }
                    }
                }
                
                // Overlay for loading
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.2))
                }
                
                // Overlay for error
                if let error = viewModel.error {
                    Text("Error: \(error.localizedDescription)")
                        .foregroundColor(.red)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                }
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
    
    @ViewBuilder
    var emptyView: some View {
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
    }
}

#Preview {
    HomeView()
}
