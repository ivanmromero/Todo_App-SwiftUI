//
//  IconNames.swift
//  Todo App
//
//  Created by Ivan Romero on 22/02/2024.
//

import Foundation
import SwiftUI

class IconNames: ObservableObject {
    var iconNames: [String?] = [nil]
    @Published var currentIndex = 0
    
    init() {
        getAlternateIconNames()
        
        if let currentIcon = UIApplication.shared.alternateIconName {
            currentIndex = iconNames.firstIndex(of: currentIcon) ?? 0
        }
    }
    
    func getAlternateIconNames() {
        if let icons = Bundle.main.object(forInfoDictionaryKey: "CFBundleIcons") as? [String: Any],
           let alternateIcons = icons["CFBundleAlternateIcons"] as? [String: Any] {
            for (_ , value) in alternateIcons {
                guard let iconList = value as? [String: Any],
                      let iconFiles = iconList["CFBundleIconFiles"] as? [String],
                      let icon = iconFiles.first else { return }
                
                iconNames.append(icon)
            }
        }
    }
}
