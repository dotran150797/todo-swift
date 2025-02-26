//
//  MainTabView.swift
//  tudu-app
//
//  Created by Do Tran on 26/2/25.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    @State private var showAddTodo = false
    
    init() {
        // Configure TabBar appearance
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(hex: "#363636")
        
        // Apply to both standard and scroll edge appearances
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        Label("Menu", systemImage: "house.fill")
                    }
                    .tag(0)
                
                CalendarView()
                    .tabItem {
                        Label("Calendar", systemImage: "calendar")
                    }
                    .tag(1)
                
                FocusView()
                    .tabItem {
                        Label("Focus", systemImage: "clock")
                    }
                    .tag(2)
                
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person")
                    }
                    .tag(3)
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        showAddTodo.toggle()
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                            .background(Color(hex: "#8687E7"))
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    }
                    .offset(y: -30)
                    Spacer()
                }
            }
        }
        .sheet(isPresented: $showAddTodo) {
            AddTodoView(isPresented: $showAddTodo)
                .presentationDetents([.fraction(0.5)])
        }
    }
}

#Preview {
    MainTabView()
}
