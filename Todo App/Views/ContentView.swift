//
//  ContentView.swift
//  Todo App
//
//  Created by Ivan Romero on 19/02/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - PROPERTIES
    @State private var showingAddTodoView: Bool = false
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)],
        animation: .default)
    private var todos: FetchedResults<Todo>

    // MARK: - BODY
    var body: some View {
        NavigationStack {
            List {
                ForEach(todos, id: \.self) { todo in
                    HStack(alignment: .center) {
                        Text(todo.name ?? "Unknown")
                        
                        Spacer()
                        
                        Text(todo.priority ?? "Unknown")
                    }
                }
                .onDelete(perform: { indexSet in
                    deleteTodo(offsets: indexSet)
                })
            }
            .navigationTitle("Todo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showingAddTodoView.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    })
                    .sheet(isPresented: $showingAddTodoView, content: {
                        AddTodoView().environment(\.managedObjectContext, viewContext)
                    })
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            })
        }
    }

    private func deleteTodo(offsets: IndexSet) {
        withAnimation {
            offsets.map { todos[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                print(error)
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()


// MARK: - PROPERTIES
#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
