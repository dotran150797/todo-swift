//
//  AddTodoViewModel.swift
//  tudu-app
//
//  Created by Do Tran on 26/2/25.
//
import SwiftUI

@MainActor
final class AddTodoViewModel: ObservableObject {
    @Published var todoText: String = ""
    @Published var descriptionText: String = ""
    @Published var createdAt: Date = Date()
    @Published var category: Todo.Category = .work
    @Published var priority: Todo.Priority = .low
    @Published var isLoading: Bool = false
    @Published var error: Error?
    
    var createdAtString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: createdAt)
    }
    
    func addTodo() async throws {
        isLoading = true
        defer {
            isLoading = false
        }
        
        do {
            try await convex.mutation(
                "tasks:create",
                with: [
                    "title": todoText,
                    "description": descriptionText,
                    "createdAt": createdAtString,
                    "category": Double(category.rawValue),
                    "priority": Double(priority.rawValue),
                    "isCompleted": false
                ]
            )
        } catch {
            self.error = error
        }
    }
    
}
