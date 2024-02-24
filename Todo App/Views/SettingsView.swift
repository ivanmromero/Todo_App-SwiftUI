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
    @EnvironmentObject var iconSettings: IconNames
    
    @ObservedObject var theme = ThemeSettings.shared
    
    @State private var isThemeChanged: Bool = false
    // MARK: - FUNCTIONS
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 0) {
                // MARK: - FORM
                Form {
                    // MARK: - SECTION 1
                    Section {
                        Picker(selection: $iconSettings.currentIndex) {
                            ForEach(0..<iconSettings.iconNames.count, id: \.self) { index in
                                HStack {
                                    Image(uiImage: UIImage(named: iconSettings.iconNames[index] ?? "Blue") ?? UIImage())
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 44, height: 44)
                                        .clipShape(.rect(cornerRadius: 8))
                                    
                                    Spacer().frame(width: 8)
                                    
                                    Text(iconSettings.iconNames[index] ?? "Blue")
                                        .frame(alignment: .leading)
                                }
                                .padding(3)
                            }
                        } label: {
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                                        .strokeBorder(.primary, lineWidth: 2)
                                    
                                    Image(systemName: "paintbrush")
                                        .font(.system(size: 28, weight: .regular, design: .default))
                                    .foregroundStyle(.primary)
                                }
                                .frame(width: 44, height: 44)
                                
                                Text("App Icons".uppercased())
                                    .fontWeight(.bold)
                                    .foregroundStyle(.primary)
                            }
                        }
                        .onReceive([iconSettings.currentIndex].publisher.first()) { (value) in
                            let index = iconSettings.iconNames.firstIndex(of: UIApplication.shared.alternateIconName) ?? 0
                            
                            if index != value {
                                UIApplication.shared.setAlternateIconName(iconSettings.iconNames[value]) { error in
                                    if let error = error {
                                        print(error.localizedDescription)
                                    } else {
                                        print("Succes, change de icon")
                                    }
                                }
                            }
                        }
                        .pickerStyle(.navigationLink)

                    } header: {
                        Text("Choose the app icon")
                    }
                    .padding(.vertical, 3)

                    // MARK: - SECTION 2
                    Section {
                        List(themeData, id: \.id) { item in
                            Button {
                                theme.themeSettings = item.id
                                UserDefaults.standard.set(theme.themeSettings, forKey: "Theme")
                                isThemeChanged.toggle()
                            } label: {
                                HStack {
                                    Image(systemName: "circle.fill")
                                        .foregroundStyle(item.themeColor)
                                    
                                    Text(item.themeName)
                                }
                            }
                            .tint(.primary)
                        }
                        
                    } header: {
                        HStack {
                            Text("Choose the app theme")
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 10, height: 10)
                                .foregroundStyle(themeData[theme.themeSettings].themeColor)
                        }
                    }
                    .padding(.vertical, 3)
                    .alert("SUCCESS!", isPresented: $isThemeChanged) {
                        Button("OK", action: {})
                    } message: {
                        Text("App has been change to the \(themeData[theme.themeSettings].themeName).".capitalized)
                    }
                    
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
        .tint(themeData[theme.themeSettings].themeColor)
    }
}

// MARK: - PREVIEW
#Preview {
    SettingsView().environmentObject(IconNames())
}
