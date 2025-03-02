//
//  HomeViewModel.swift
//  tudu-app
//
//  Created by Do Tran on 2/3/25.
//
import SwiftUI

@MainActor
final class HomeViewModel: ObservableObject {
    @Published private(set) var tasks: [Todo] = [] {
        didSet {
            updateDerivedTasks()
        }
    }
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var error: Error?
    @Published private(set) var todayTasks: [Todo] = []
    @Published private(set) var competedTasks: [Todo] = []
    
    private var fetchTask: Task<Void, Never>?
        
    init() {
        fetchTasks()
    }
    
    private func updateDerivedTasks() {
        // Filter today's tasks
        let today = Calendar.current.startOfDay(for: Date())
    
        let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        todayTasks = tasks.filter {
            guard let taskDate = formatter.date(from: $0.createdAt) else { return false }
            return Calendar.current.isDate(taskDate, inSameDayAs: today)
        }
        
        // Sort by priority
        todayTasks = todayTasks.sorted { $0.priority.rawValue > $1.priority.rawValue }
        
        competedTasks = tasks.filter { $0.isCompleted }
    }
    
    private func fetchTasks() {
        fetchTask = Task { [weak self] in
            guard let self else { return }
            
            self.updateLoadingState(true)
            
            do {
                let latestTasks = convex.subscribe(to: "tasks:get", yielding: [Todo].self)
                    .eraseToAnyPublisher()
                
                var isFirstFetch = true
                for try await items in latestTasks.values {
                    self.updateTasks(items)
                    if isFirstFetch {
                        self.updateLoadingState(false) // Set to false after first data
                        isFirstFetch = false
                    }
                }
            } catch {
                self.handleError(error)
                updateLoadingState(false)
            }
        }
    }
    
    // Method to toggle task completion
    func toggleTaskCompletion(_ task: Todo) {
        Task {
            do {
                try await convex.mutation("tasks:toggleCompletion", with: ["id": task.id, "isCompleted": !task.isCompleted])
            } catch {
                print("Failed to sync task update: \(error)")
            }
        }
    }
    
    private func cancelFetchTasks() {
            fetchTask?.cancel()
            fetchTask = nil
    }
    
    private func updateTasks(_ newTasks: [Todo]) {
        tasks = newTasks
    }
    
    private func updateLoadingState(_ loading: Bool) {
        isLoading = loading
    }
    
    private func handleError(_ error: Error) {
        self.error = error
        tasks = []
        print("Error fetching tasks: \(error.localizedDescription)")
    }
}
