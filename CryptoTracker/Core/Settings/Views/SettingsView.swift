//
//  SettingsView.swift
//  CryptoTracker
//
//  Created by Anton Tropin on 02.11.23.
//

import SwiftUI

struct SettingsView: View {
    
    let defaultURL = URL(string: "https://google.com")!
    let youtubeURL = URL(string: "https://youtube.com/c/swiftfulthinking")!
    let coingeckoURL = URL(string: "https://coingecko.com")!
    let personalURL = URL(string: "https://github.com/bbetsey")!
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.theme.background
                    .ignoresSafeArea()
                List {
                    swiftfulThinkingSection
                    coingeckoSection
                    developerSection
                    applicationSection
                }
            }
            .navigationTitle("Inforamtion")
        }
    }
}

// MARK: - COMPONENTS

private extension SettingsView {
    var swiftfulThinkingSection: some View {
        Section(header: Text("Swiftful Thinking")) {
            HStack(spacing: 16) {
                Image("logo")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                VStack(alignment: .leading) {
                    Text("This app was made by following a @SwiftfulThinking course on YouTube. It uses MVVM Architecture, Combine, and CoreData.")
                        .font(.caption.weight(.medium))
                        .foregroundStyle(Color.theme.accent)
                    Link(destination: youtubeURL) {
                        Text("Subscribe on YouTube")
                            .frame(maxWidth: .infinity)
                            .font(.caption)
                            .foregroundStyle(Color.theme.accent)
                            .padding(.vertical, 7)
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.secondary.opacity(0.25))
                                    .frame(maxWidth: .infinity)
                            )
                    }
                    
                }
            }
            .padding(.vertical)
        }
    }
    
    var coingeckoSection: some View {
        Section(header: Text("CoinGecko")) {
            HStack(spacing: 16) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                VStack(alignment: .leading) {
                    Text("The cryptocurrency data that is used in this app comes from a free API from CoinGecko! Prices may be slightly delayed.")
                        .font(.caption.weight(.medium))
                        .foregroundStyle(Color.theme.accent)
                    Link(destination: youtubeURL) {
                        Text("Visit CoinGecko")
                            .frame(maxWidth: .infinity)
                            .font(.caption)
                            .foregroundStyle(Color.theme.accent)
                            .padding(.vertical, 7)
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.secondary.opacity(0.25))
                                    .frame(maxWidth: .infinity)
                            )
                    }
                }
            }
            .padding(.vertical)
        }
    }
    
    var developerSection: some View {
        Section(header: Text("Developer")) {
            HStack(spacing: 16) {
                Image("photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                VStack(alignment: .leading) {
                    Text("This app was developed by Anton Tropin. It uses 100% SwiftUI. The project benefits from multi-threading, publishers/subscribers, and data persistance.")
                        .font(.caption.weight(.medium))
                        .foregroundStyle(Color.theme.accent)
                    Link(destination: personalURL) {
                        Text("Visit GitHub")
                            .frame(maxWidth: .infinity)
                            .font(.caption)
                            .foregroundStyle(Color.theme.accent)
                            .padding(.vertical, 7)
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.secondary.opacity(0.25))
                                    .frame(maxWidth: .infinity)
                            )
                    }
                }
            }
            .padding(.vertical)
        }
    }
    
    var applicationSection: some View {
        Section(header: Text("Application")) {
            Link("Terms of Service", destination: defaultURL)
            Link("Provacy Policy", destination: defaultURL)
            Link("Company Website", destination: defaultURL)
            Link("Learn More", destination: defaultURL)
        }
    }
}

// MARK: - PREVIEW

#Preview {
    SettingsView()
        .preferredColorScheme(.dark)
}
