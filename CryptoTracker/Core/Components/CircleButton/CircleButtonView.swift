//
//  CircleButtonView.swift
//  CryptoTracker
//
//  Created by Anton Tropin on 28.10.23.
//

import SwiftUI

struct CircleButtonView: View {
    
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundStyle(Color.theme.accent)
            .frame(width: 50, height: 50)
            .background(Color.theme.background)
            .clipShape(Circle())
            .shadow(
                color: Color.theme.accent.opacity(0.25),
                radius: 10, x: 0, y: 0
            )
    }
}

#Preview {
    Group {
        CircleButtonView(iconName: "info")
    }
}
