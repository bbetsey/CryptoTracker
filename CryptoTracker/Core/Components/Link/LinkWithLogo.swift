//
//  LinkWithLogo.swift
//  CryptoTracker
//
//  Created by Anton Tropin on 01.11.23.
//

import SwiftUI

struct LinkWithLogo: View {
    
    private let title: String
    private let url: URL
    private let logo: Image
    
    init(title: String, url: URL, logo: Image) {
        self.title = title
        self.url = url
        self.logo = logo
    }
    
    var body: some View {
        Link(destination: url) {
            HStack(spacing: 0) {
                logo
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 30, height: 30)
                    .foregroundStyle(Color.theme.background)
                Text(title)
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(Color.theme.background)
            }
        }
        .padding(.trailing, 8)
        .padding(.horizontal, 2)
        .background(Capsule().fill(Color.theme.accent))
    }
}

#Preview {
    LinkWithLogo(title: "twitter", url: URL(string: "https://twitter.com")!, logo: Image("Reddit"))
//        .preferredColorScheme(.dark)
}
