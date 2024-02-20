//
//  AddTodoView.swift
//  Todo App
//
//  Created by Ivan Romero on 19/02/2024.
//

import SwiftUI

struct AddTodoView: View {
    // MARK: - PROPERTIES
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var priority: String = "Normal"
    
    let priorities: [String] = ["High", "Normal", "Low"]
    
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
        }
    }
}

// MARK: - PREVIEW
#Preview {
    AddTodoView()
}
