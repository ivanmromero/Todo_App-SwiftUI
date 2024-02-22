//
//  SettingsView.swift
//  Todo App
//
//  Created by Ivan Romero on 21/02/2024.
//

import SwiftUI

struct SettingsView: View {
    // MARK: - PROPERTIES
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - FUNCTIONS
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 0) {
                // MARK: - FORM
                Form {
                    // MARK: - SECTION 3
                    Section {
                        FormRowLinkView(icon: "globe", color: .pink, text: "LinkedIn", link: "https://linkedin.com/in/ivan-manuel-romero-sampayo/")
                        FormRowLinkView(icon: "link", color: .blue, text: "Github", link: "https://github.com/ivanmromero")
                    } header: {
                        Text("Follow me on social media")
                    }
                    .padding(.vertical, 3)

                    
                    // MARK: - SECTION 4
                    Section {
                        FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Todo")
                        FormRowStaticView(icon: "checkmark.seal", firstText: "Comptibility", secondText: "iPhone, iPad")
                        FormRowStaticView(icon: "keyboard", firstText: "Developer", secondText: "Ivan Manuel Romero")
                        FormRowStaticView(icon: "flag", firstText: "Version", secondText: "1.0.0")
                    } header: {
                        Text("About the application")
                    }
                    .padding(.vertical, 3)

                    
                }
                .listStyle(.grouped)
                .environment(\.horizontalSizeClass, .regular)
                
                // MARK: - FOOTER
                VStack {
                    Text("TodoApp")
                    Text("Better Apps Less Code")
                }
                .multilineTextAlignment(.center)
                .font(.footnote)
                .padding(.top, 6)
                .padding(.bottom, 8)
                .foregroundStyle(.secondary)
                
    
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }

                }
            })
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .background(.colorBackground)
        }
    }
}

// MARK: - PREVIEW
#Preview {
    SettingsView()
}
