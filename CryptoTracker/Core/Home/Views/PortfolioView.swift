//
//  PortfolioView.swift
//  CryptoTracker
//
//  Created by Anton Tropin on 30.10.23.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var quantityText: String = ""
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                    coinLogoList
                        .padding(.leading)
                    
                    if vm.selectedCoin != nil {
                        PortfolioTransactionView(quantityText: $quantityText)
                            .padding()
                            .padding(.vertical)
                            .animation(.none, value: UUID())
                    }
                }
            }
            .background(Color.theme.background.ignoresSafeArea())
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(
                    placement: .topBarLeading,
                    content: { XMarkButton().environmentObject(vm) }
                )
            }
            .onChange(of: vm.searchText, perform: { value in
                if value == "" { vm.selectedCoin = nil }
            })
        }
    }
}

// MARK: - COMPONENTS

private extension PortfolioView {
    var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(vm.searchText.isEmpty ? vm.portfolioCoins : vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .onTapGesture() {
                            withAnimation(.easeIn) {
                                updateSelectedCoin(coin: coin)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .strokeBorder(
                                    (vm.selectedCoin?.id == coin.id)
                                    ? Color.theme.green
                                    : Color.clear
                                )
                        )
                }
            }
        }
    }
}

// MARK: - PRIVATE METHODS

private extension PortfolioView {
    func updateSelectedCoin(coin: Coin) {
        vm.selectedCoin = coin
        
        if let portfolioCoin = vm.portfolioCoins.first(where: { $0.id == coin.id }),
           let amount = portfolioCoin.currentHoldings {
            quantityText = "\(amount)"
        } else {
            quantityText = ""
        }
    }
}

#Preview {
    PortfolioView()
        .environmentObject(HomeViewModel())
//        .preferredColorScheme(.dark)
}
