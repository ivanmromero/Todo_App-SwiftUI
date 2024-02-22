//
//  FormRowLinkView.swift
//  Todo App
//
//  Created by Ivan Romero on 21/02/2024.
//

import SwiftUI

struct FormRowLinkView: View {
    // MARK: - PROPERTIES
    let icon: String
    let color: Color
    let text: String
    let link: String

    // MARK: - FUNCTIONS
    
    // MARK: - BODY
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(color)
                Image(systemName: icon)
                    .imageScale(.large)
                    .foregroundStyle(.white)
            }
            .frame(width: 36, height: 36, alignment: .center)
            
            Text(text)
                .foregroundStyle(.gray)
            
            Spacer()
            
            if let url = URL(string: link), UIApplication.shared.canOpenURL(url) {
                Link(destination: url) {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                }
                .tint(Color(.systemGray2))
            }
        }
    }
}

// MARK: - PREVIEW
#Preview(traits: .fixedLayout(width: 375, height: 60)) {
    FormRowLinkView(icon: "globe", color: .pink, text: "website", link: "https://linkedin.com/in/ivan-manuel-romero-sampayo/")
        .padding()
}
