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
    @State private var animatingButton: Bool = false
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)],
        animation: .default)
    private var todos: FetchedResults<Todo>

    // MARK: - BODY
    var body: some View {
        NavigationStack {
            ZStack {
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
                        
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        EditButton()
                    }
                })
                
                // MARK: - NO TODO ITEMS
                if todos.isEmpty {
                    EmptyListView()
                }
            }
            .sheet(isPresented: $showingAddTodoView, content: {
                AddTodoView().environment(\.managedObjectContext, viewContext)
            })
            .overlay(alignment: .bottomTrailing) {
                ZStack {
                    Group {
                        Circle()
                            .fill(.blue)
                            .opacity(animatingButton ? 0.2 : 0)
                            .scaleEffect(animatingButton ? 1 : 0)
                            .frame(width: 68, height: 68, alignment: .center)
                        Circle()
                            .fill(.blue)
                            .opacity(animatingButton ? 0.15 : 0)
                            .scaleEffect(animatingButton ? 1 : 0)
                            .frame(width: 88, height: 88, alignment: .center)
                    }
                    
                    
                    Button {
                        showingAddTodoView.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .background(Circle().fill(.colorBase))
                            .frame(width: 48, height: 48, alignment: .center)
                    }
                    .onAppear(perform: {
                        DispatchQueue.main.async {
                            withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                                self.animatingButton.toggle()
                            }
                        }
                    })
                    
                }
                .padding(.bottom, 15)
                .padding(.trailing, 15)
            }
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
