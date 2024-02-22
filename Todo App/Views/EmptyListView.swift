//
//  EmptyListView.swift
//  Todo App
//
//  Created by Ivan Romero on 20/02/2024.
//

import SwiftUI

struct EmptyListView: View {
    // MARK: - PROPERTIES
    @State private var isAnimating: Bool = false
    private let images: [ImageResource] = [.illustrationNo1, .illustrationNo2, .illustrationNo3]
    
    let tips: [String] = [
        "Use your time wisely.",
        "Slow and steady wins the race.",
        "Keep it short and sweet.",
        "Put hard tasks first.",
        "Reward yourself after work.",
        "Collect tasks ahead of time.",
        "Each night schelude for tomorrow."
    ]
    
    // MARK: - FUNCTIONS
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 20) {
                Image(images.randomElement() ?? images[0])
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 256, idealWidth: 280, maxWidth: 360, minHeight: 256, idealHeight: 280, maxHeight: 360, alignment: .center)
                    .layoutPriority(1)
                
                Text(tips.randomElement() ?? tips[0])
                    .layoutPriority(0.5)
                    .font(.system(.headline, design: .rounded))
            }
            .padding(.horizontal)
            .opacity(isAnimating ? 1 : 0)
            .offset(y: isAnimating ? 0 : -50)
            .onAppear(perform: {
                DispatchQueue.main.async {
                    withAnimation(.easeOut(duration: 1.5)) {
                        isAnimating.toggle()
                    }
                }
            })
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color.colorBase)
        .ignoresSafeArea()
    }
}

// MARK: - PREVIEW
#Preview {
    EmptyListView()
}
