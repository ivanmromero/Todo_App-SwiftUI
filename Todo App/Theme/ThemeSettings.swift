//
//  ThemeSettings.swift
//  Todo App
//
//  Created by Ivan Romero on 24/02/2024.
//

import Foundation

class ThemeSettings: ObservableObject {
    public static let shared = ThemeSettings()

    @Published var themeSettings: Int = UserDefaults.standard.integer(forKey: "Theme") {
        didSet {
            UserDefaults.standard.set(themeSettings, forKey: "Theme")
        }
    }
    
    private init() {}
}
