//
//  DetailView.swift
//  CryptoTracker
//
//  Created by Anton Tropin on 01.11.23.
//

import SwiftUI

struct DetailLoadingView: View {
    @Binding var coin: Coin?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    
    @StateObject private var vm: DetailViewModel
    @State private var showFullDescription: Bool = false
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    private let spacing: CGFloat = 20
    
    init(coin: Coin) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ChartView(coin: vm.coin)
                    .padding(.horizontal)
                    .padding(.vertical)
                
                VStack(spacing: 20) {
                    overviewHeader
                    linkSection
                    Divider()
                    descriptionSection
                    overviewGrid
                    additionalHeader
                    Divider()
                    additionalGrid
                }
                .padding()
            }
        }
        .background(Color.theme.background.ignoresSafeArea())
        .navigationTitle(vm.coin.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarTrailingItems
            }
        }
    }
}

// MARK: - COMPONENTS

private extension DetailView {
    var overviewHeader: some View {
        getStatDetailsHeader(with: "Overview")
    }
    
    var additionalHeader: some View {
        getStatDetailsHeader(with: "Additional Details")
    }
    
    var overviewGrid: some View {
        getStatDetail(with: vm.overviewStatisctics)
    }
    
    var additionalGrid: some View {
        getStatDetail(with: vm.additionalStatisctics)
    }
    
    var navigationBarTrailingItems: some View {
        HStack {
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.secondaryText)
            CoinImageView(coin: vm.coin)
                .frame(width: 25, height: 25)
        }
    }
    
    var descriptionSection: some View {
        ZStack {
            if let coinDescription = vm.coinDescription, !coinDescription.isEmpty {
                VStack(alignment: .leading) {
                    Text(coinDescription)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.callout)
                        .foregroundStyle(Color.theme.secondaryText)
                    Button {
                        withAnimation {
                            showFullDescription.toggle()
                        }
                    } label: {
                        Text(showFullDescription ? "Collapse ↑" : "Read more ↓")
                    }
                    .tint(.blue)
                    .font(.footnote.weight(.bold))
                    .padding(.vertical, 1)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    var linkSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                if let homeURL = vm.websiteURL,
                   let url = URL(string: homeURL) {
                    LinkWithSystemLogo(title: "Home", url: url, systemLogo: Image(systemName: "house.fill"))
                }
                if let twitterURL = vm.twitterURL,
                   let url = URL(string: twitterURL) {
                    LinkWithLogo(title: "Twitter", url: url, logo: Image("Twitter"))
                }
                if let telegramURL = vm.telegramURL,
                   let url = URL(string: telegramURL) {
                    LinkWithLogo(title: "Telegram", url: url, logo: Image("Telegram"))
                }
                if let redditURL = vm.redditURL,
                   let url = URL(string: redditURL) {
                    LinkWithLogo(title: "Reddit", url: url, logo: Image("Reddit"))
                }
                if let facebookURL = vm.facebookURL,
                   let url = URL(string: facebookURL) {
                    LinkWithLogo(title: "Facebook", url: url, logo: Image("Facebook"))
                }
                Spacer()
            }
        }
    }
}


// MARK: - PRIVATE METHODS

private extension DetailView {
    func getStatDetailsHeader(with title: String) -> some View {
        Text(title)
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func getStatDetail(with stat: [Statistic]) -> some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: []) {
                ForEach(stat) { stat in
                    StatisticsBarView(stat: stat)
                }
            }
    }
}

#Preview {
    NavigationView {
        DetailView(coin: Coin.coin)
            .preferredColorScheme(.dark)
    }
}
