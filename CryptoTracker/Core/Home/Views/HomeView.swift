//
//  HomeView.swift
//  CryptoTracker
//
//  Created by Anton Tropin on 28.10.23.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false // animation right
    @State private var showPortfolioView: Bool = false // new sheet
    @State private var selectCoin: Coin? = nil
    @State private var showDetailView: Bool = false
    @State private var showSettingsView: Bool = false
    
    var body: some View {
        ZStack {
            // background
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView, content: {
                    PortfolioView()
                })
            
            // content layer
            VStack {
                homeHeader
                HomeStatsView(showPortfolio: $showPortfolio)
                    .padding(.top)
                SearchBarView(searchText: $vm.searchText)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                columnTitles
                
                if !showPortfolio {
                    allCoinsList.transition(.move(edge: .leading))
                } else {
                    ZStack(alignment: .top) {
                        if vm.portfolioCoins.isEmpty && vm.searchText.isEmpty {
                            portfolioEmptyText
                        } else {
                            allPortfolioCoinsList
                        }
                    }
                    .transition(.move(edge: .trailing))
                }
                
                Spacer(minLength: 0)
            }
            .sheet(isPresented: $showSettingsView, content: {
                SettingsView()
            })
        }
        .background(
            NavigationLink(
                destination: DetailLoadingView(coin: $selectCoin),
                isActive: $showDetailView,
                label: { EmptyView() }
            )
        )
    }
}

// MARK: COMPONENTS

private extension HomeView {
    
    var homeHeader: some View {
        HStack {
            ZStack {
                CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                    .animation(.none, value: showPortfolio)
                    .onTapGesture {
                        if showPortfolio { showPortfolioView.toggle() }
                        else { showSettingsView.toggle() }
                    }
                CircleButtonAnimationView(animate: $showPortfolio)
            }
            .frame(maxWidth: 50, maxHeight: 50)
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline.weight(.heavy))
                .foregroundStyle(Color.theme.accent)
                .animation(.none, value: showPortfolio)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(.degrees(showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    var allCoinsList: some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10)))
                    .padding(.vertical, 4)
                    .onTapGesture {
                        segue(coin: coin)
                    }
                    .listRowBackground(Color.theme.background)
            }
        }
        .padding(.horizontal, 12)
        .listStyle(.plain)
    }
    
    var allPortfolioCoinsList: some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10)))
                    .padding(.vertical, 4)
                    .onTapGesture {
                        segue(coin: coin)
                    }
                    .listRowBackground(Color.theme.background)
            }
        }
        .padding(.horizontal, 12)
        .listStyle(.plain)
    }
    
    var columnTitles: some View {
        HStack {
            
            HStack {
                Text("#")
                Text("Coin")
                    .padding(.leading, 4)
                Image(systemName: "chevron.down")
                    .foregroundStyle(vm.sortOption == .rank || vm.sortOption == .rankReversed
                                     ? Color.theme.green
                                     : Color.theme.secondaryText)
                    .rotationEffect(.init(degrees: vm.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }
            }
            
            Spacer()
            
            if showPortfolio {
                HStack {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .foregroundStyle(vm.sortOption == .holdings || vm.sortOption == .holdingsReversed
                                         ? Color.theme.green
                                         : Color.theme.secondaryText)
                        .rotationEffect(.init(degrees: vm.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default) {
                        vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
                    }
                }
            }
            
            HStack {
                Text("Price")
                    .frame(width: UIScreen.main.bounds.width / 6.2, alignment: .trailing)
                Image(systemName: "chevron.down")
                    .foregroundStyle(vm.sortOption == .price || vm.sortOption == .priceReversed
                                     ? Color.theme.green
                                     : Color.theme.secondaryText)
                    .rotationEffect(.init(degrees: vm.sortOption == .price ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                }
            }
            
            Button {
                withAnimation(.linear(duration: 0.2)) {
                    vm.reloadData()
                }
            } label: {
                Image(systemName: "goforward")
            }
            .rotationEffect(.init(degrees: vm.isLoading ? 360 : 0), anchor: .center)

        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.top, 8)
        .padding(.horizontal, 22)
    }
    
    var portfolioEmptyText: some View {
        Text("You haven't added any coins to your portfolio yet. Click the + button in the top of the right left corner to get started! 🧐")
            .font(.callout.weight(.medium))
            .foregroundStyle(Color.theme.secondaryText)
            .multilineTextAlignment(.center)
            .padding(50)
    }
    
}

// MARK: - PRIVATE METHODS

private extension HomeView {
    func segue(coin: Coin) {
        selectCoin = coin
        showDetailView.toggle()
    }
}

// MARK: - PREVIEW

#Preview("Home View") {
    NavigationView {
        HomeView()
            .environmentObject(HomeViewModel())
//            .preferredColorScheme(.dark)
    }
}
