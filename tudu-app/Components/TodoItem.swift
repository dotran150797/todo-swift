//
//  TodoItem.swift
//  tudu-app
//
//  Created by Do Tran on 2/3/25.
//

import SwiftUI

struct TodoItem: View {
    @ObservedObject var viewModel: HomeViewModel
    let todo: Todo
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Completion Toggle
            Toggle("", isOn: Binding(
                get: { todo.isCompleted },
                set: { _ in viewModel.toggleTaskCompletion(todo) }
            ))
            .labelsHidden()
            .toggleStyle(.switch)
            .frame(width: 40) // Fixed width for alignment
            
            // Task Details
            VStack(alignment: .leading, spacing: 4) {
                // Title
                Text(todo.title)
                    .font(.headline)
                    .foregroundColor(todo.isCompleted ? .gray : .primary)
                
                // Description (if not empty)
                if !todo.description.isEmpty {
                    Text(todo.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                
                // Metadata Row
                HStack(spacing: 8) {
                    // Created At
                    Text(todo.createdAt)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    // Priority
                    Text(todo.priority.displayName)
                        .font(.caption)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(priorityColor.opacity(0.2))
                        .foregroundColor(priorityColor)
                        .clipShape(Capsule())
                    
                    // Category
                    Text(todo.category.stringValue)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.vertical, 8)
    }
    
    // Helper for priority color
    private var priorityColor: Color {
        switch todo.priority {
        case .none: return .gray
        case .low: return .blue
        case .medium: return .orange
        case .high: return .red
        }
    }
}

#Preview {
    TodoItem(
        viewModel: HomeViewModel(),
        todo: Todo(
            id: "1",
            title: "Sample Task",
            description: "",
            isCompleted: false,
            createdAt: "2025-03-02 14:30:00",
            priority: .medium,
            category: .work,
            creationTime: 123
        )
    )
}
