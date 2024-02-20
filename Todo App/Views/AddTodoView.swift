//
//  AddTodoView.swift
//  Todo App
//
//  Created by Ivan Romero on 19/02/2024.
//

import SwiftUI

struct AddTodoView: View {
    // MARK: - PROPERTIES
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var priority: String = "Normal"
    
    let priorities: [String] = ["High", "Normal", "Low"]
    
    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    
    // MARK: - FUNCTIONS
    private func save() {
        if !name.isEmpty {
            let todo = Todo(context: viewContext)
            todo.name = name
            todo.priority = priority
            
            do {
                try viewContext.save()
            } catch {
                print(error)
            }
            
            dismiss()
        } else {
            errorShowing = true
            errorTitle = "Invalid Name"
            errorMessage = "Make sure to enter something for\nthe new todo item."
        }
    }
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            VStack {
                Form(content: {
                    // MARK: - TODO NAME
                    TextField("Todo", text: $name)
                    
                    // MARK: - PRIORITY
                    Picker("Priority", selection: $priority) {
                        ForEach(priorities, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    // MARK: - SAVE BUTTON
                    Button(action: {
                        save()
                    }, label: {
                        Text("Save")
                    })
                })
                
                Spacer()
            }
            .navigationTitle("New Todo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                    })
                }
            })
            .alert(errorTitle, isPresented: $errorShowing) {
                Button("OK", action: {})
            } message: {
                Text(errorMessage)
            }

        }
    }
}

// MARK: - PREVIEW
#Preview {
    AddTodoView()
}
