//
//  TodoItem.swift
//  tudu-app
//
//  Created by Do Tran on 2/3/25.
//

import SwiftUI

struct TodoItem: View {
    @ObservedObject var viewModel: HomeViewModel
    var todo: Todo
    
    var body: some View {
        GroupBox {
            HStack {
                VStack(alignment: .leading) {
                    Text(todo.title)
                        .latoBoldFont(size: FontSizes.h3)
                    
                    Text(todo.description)
                }
                Spacer()
                Toggle("", isOn: Binding(get: {
                    todo.isCompleted
                }, set: { _ in
                    viewModel.toggleTaskCompletion(todo)
                }))
            }
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
