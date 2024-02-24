//
//  FormRowStaticView.swift
//  Todo App
//
//  Created by Ivan Romero on 21/02/2024.
//

import SwiftUI

struct FormRowStaticView: View {
    // MARK: - PROPERTIES
    let icon: String
    let firstText: String
    let secondText: String
    
    // MARK: - FUNCTIONS
    
    // MARK: - BODY
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(.gray)
                Image(systemName: icon)
                    .foregroundStyle(.white)
            }
            .frame(width: 36, height: 36, alignment: .center)
            
            Text(firstText)
                .foregroundStyle(.gray)
            
            Spacer()
            
            Text(secondText)
        }
    }
}

// MARK: - PREVIEW
#Preview(traits: .fixedLayout(width: 375, height: 60)) {
    FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Todo")
        .padding()
}
