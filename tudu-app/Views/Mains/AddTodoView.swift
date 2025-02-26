//
//  AddTodoView.swift
//  tudu-app
//
//  Created by Do Tran on 26/2/25.
//

import SwiftUI

enum FocusedField {
    case newTodoText, description
}

struct AddTodoView: View {
    @StateObject private var viewModel: AddTodoViewModel = AddTodoViewModel()
    @FocusState private var focusedField: FocusedField?
    @Binding var isPresented: Bool
    @State private var showingErrorAlert = false

    var body: some View {
        Form {
            Section(header: Text("Add a new task")) {
                TextField("Add your task here", text: $viewModel.todoText)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray)
                    )
                    .focused($focusedField, equals: .newTodoText)

                TextField("Add your task description here", text: $viewModel.descriptionText)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray)
                    )
                    .focused($focusedField, equals: .description)
                
                HStack {
                    Image(systemName: "clock.circle")
                        .font(.system(size: 20))
                    
                    DatePicker(
                            "",
                            selection: $viewModel.createdAt,
                            displayedComponents: [.date,.hourAndMinute]
                        )
                    .datePickerStyle(.compact)
                }
                
                List {
                    Picker("Category", selection: $viewModel.category) {
                        Text("Personal").tag(TaskCategory.personal)
                        Text("Work").tag(TaskCategory.work)
                        Text("Other").tag(TaskCategory.other)
                    }
                }
                
                List {
                    Picker("Priority", selection: $viewModel.priority) {
                        Text("Low").tag(TaskPriority.low)
                        Text("Medium").tag(TaskPriority.medium)
                        Text("High").tag(TaskPriority.high)
                    }
                }
                
                TButton(title: "Add", isPrimary: true, isLoading: viewModel.isLoading, action: {
                    Task {
                        try await viewModel.addTodo()
                        showingErrorAlert = viewModel.error != nil
                        if !showingErrorAlert {
                            isPresented.toggle()
                        }
                    }
                })
            }
            
        }
        .onAppear {
            focusedField = .newTodoText
        }
        .alert(isPresented: $showingErrorAlert) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.error?.localizedDescription ?? "An unknown error occurred"),
                dismissButton: .default(Text("OK")) {
                    viewModel.error = nil // Clear error after dismissal
                }
            )
        }
    }
}

#Preview {
    AddTodoView(isPresented: .constant(false))
}
