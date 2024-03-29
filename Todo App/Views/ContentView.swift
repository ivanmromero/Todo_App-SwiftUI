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
    @State private var showingSettingsView: Bool = false
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var iconSettings: IconNames
    
    @ObservedObject var theme = ThemeSettings.shared

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
                            Circle()
                                .frame(width: 12, height: 12, alignment: .center)
                                .foregroundStyle(colorize(priority: todo.priority ?? "Normal"))
                                .fontWeight(.semibold)
                            
                            Text(todo.name ?? "Unknown")
                            
                            Spacer()
                            
                            Text(todo.priority ?? "Unknown")
                                .font(.footnote)
                                .foregroundStyle(Color(UIColor.systemGray2))
                                .padding(3)
                                .frame(minWidth: 62)
                                .overlay {
                                    Capsule()
                                        .stroke(Color(UIColor.systemGray2), lineWidth: 0.75)
                                }
                        }
                        .padding(.vertical, 10)
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
                            showingSettingsView.toggle()
                        }, label: {
                            Image(systemName: "paintbrush")
                                .imageScale(.large)
                        })
                        .sheet(isPresented: $showingSettingsView, content: {
                            SettingsView().environmentObject(iconSettings)
                        })
                        .tint(themeData[theme.themeSettings].themeColor)
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        EditButton()
                            .tint(themeData[theme.themeSettings].themeColor)
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
                            .fill(themeData[theme.themeSettings].themeColor)
                            .opacity(animatingButton ? 0.2 : 0)
                            .frame(width: 68, height: 68, alignment: .center)
                        Circle()
                            .fill(themeData[theme.themeSettings].themeColor)
                            .opacity(animatingButton ? 0.15 : 0)
                            .frame(width: 88, height: 88, alignment: .center)
                    }
                    .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: animatingButton)
                    .scaleEffect(animatingButton ? 1 : 0)
                    
                    
                    Button {
                        showingAddTodoView.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .background(Circle().fill(.colorBase))
                            .frame(width: 48, height: 48, alignment: .center)
                    }
                    .tint(themeData[theme.themeSettings].themeColor)
                    .onAppear(perform: {
                        self.animatingButton.toggle()
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
    
    private func colorize(priority: String) -> Color {
        switch priority {
        case "High":
                return .pink
        case "Normal":
            return .green
        case "Low":
            return .blue
        default:
            return .gray
        }
    }
}

// MARK: - PROPERTIES
#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
