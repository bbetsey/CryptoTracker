//
//  LinkWithSystemLogo.swift
//  CryptoTracker
//
//  Created by Anton Tropin on 02.11.23.
//

import SwiftUI

struct LinkWithSystemLogo: View {
    private let title: String
    private let url: URL
    private let systemLogo: Image
    
    init(title: String, url: URL, systemLogo: Image) {
        self.title = title
        self.url = url
        self.systemLogo = systemLogo
    }
    
    var body: some View {
        Link(destination: url) {
            HStack(spacing: 0) {
                systemLogo
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 14, height: 14)
                    .foregroundStyle(Color.theme.background)
                Text(title)
                    .padding(.leading, 6)
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(Color.theme.background)
            }
        }
        .padding(7)
        .padding(.horizontal, 6)
        .background(Capsule().fill(Color.theme.accent))
    }
}

#Preview {
    LinkWithSystemLogo(title: "Home", url: URL(string: "https://twitter.com")!, systemLogo: Image(systemName: "house.fill"))
}
