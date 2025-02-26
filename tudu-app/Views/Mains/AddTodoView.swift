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
    @State private var newTodoText: String = ""
    @State private var description: String = ""
    @State private var date = Date()
    @State private var selectedCategory: TaskCategory = .personal
    @State private var selectedPriority: TaskPriority = .low
    @FocusState private var focusedField: FocusedField?

    var body: some View {
        Form {
            Section(header: Text("Add a new task")) {
                TextField("Add your task here", text: $newTodoText)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray)
                    )
                    .focused($focusedField, equals: .newTodoText)

                TextField("Add your task description here", text: $description)
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
                            selection: $date,
                            displayedComponents: [.date,.hourAndMinute]
                        )
                    .datePickerStyle(.compact)
                }
                
                List {
                    Picker("Category", selection: $selectedCategory) {
                        Text("Personal").tag(TaskCategory.personal)
                        Text("Work").tag(TaskCategory.work)
                        Text("Shopping").tag(TaskCategory.shopping)
                        Text("Other").tag(TaskCategory.other)
                    }
                }
                
                List {
                    Picker("Priority", selection: $selectedPriority) {
                        Text("Low").tag(TaskPriority.low)
                        Text("Medium").tag(TaskPriority.medium)
                        Text("High").tag(TaskPriority.high)
                    }
                }
                
                TButton(title: "Add", isPrimary: true, isLoading: false, action: {
                    //
                })
            }
            
        }
        .onAppear {
            focusedField = .newTodoText
        }
    }
}

#Preview {
    AddTodoView()
}
