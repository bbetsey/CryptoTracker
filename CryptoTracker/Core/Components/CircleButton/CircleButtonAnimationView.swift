//
//  CircleButtonAnimationView.swift
//  CryptoTracker
//
//  Created by Anton Tropin on 28.10.23.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    
    @Binding var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 1.0)
            .scale(animate ? 1.2 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(
                animate ? Animation.easeOut(duration: 1.0) : .none,
                value: animate
            )
//            .onAppear { animate.toggle() }
    }
}

#Preview {
    CircleButtonAnimationView(animate: .constant(false))
}
