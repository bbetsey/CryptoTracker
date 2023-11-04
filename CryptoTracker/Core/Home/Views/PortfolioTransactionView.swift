//
//  PortfolioTransactionView.swift
//  CryptoTracker
//
//  Created by Anton Tropin on 31.10.23.
//

import SwiftUI

struct PortfolioTransactionView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @Binding var quantityText: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            nameSection
            Divider()
            coinDetailStatView
            Divider()
            coinInputAmountView
            saveButtonView
        }
    }
}

// MARK: - COMPONENTS

private extension PortfolioTransactionView {
    var nameSection: some View {
        HStack {
            Text(vm.selectedCoin?.name.uppercased() ?? "")
                .bold()
                .font(.title2)
            Text(vm.selectedCoin?.symbol.uppercased() ?? "")
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
            Spacer()
        }
    }
    
    var coinDetailStatView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(vm.detailSatistics) { stat in
                    StatisticsDetailView(stat: stat)
                }
            }
            .frame(maxHeight: 60)
        }
    }
    
    var coinInputAmountView: some View {
        HStack {
            TextField("Amount holding...", text: $quantityText)
                .font(.callout)
                .multilineTextAlignment(.center)
                .padding(12)
                .frame(width: UIScreen.main.bounds.width / 1.9)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color.theme.secondaryText)
                )
                .keyboardType(.decimalPad)
            Text("= \(getCurrentValue().asCurrencyWith2Decimals())")
                .padding(12)
                .lineLimit(1)
                .foregroundStyle(Color.theme.accent)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color.theme.accent)
                )
        }
    }
    
    var saveButtonView: some View {
        Button {
            saveButtonPressed()
        } label: {
            Text("Save")
                .foregroundStyle(Color.theme.background)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.theme.accent)
                )
        }
        .disabled(quantityText.isEmpty ? true : false)
    }
}

// MARK: - PRIVATE METHODS

private extension PortfolioTransactionView {
    func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (vm.selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    func saveButtonPressed() {
        guard
            let coin = vm.selectedCoin,
            let amount = Double(quantityText)
        else { return }
        
        // save to portfolio
        vm.updatePortfolio(coin: coin, amount: amount)
        
        // update fields
        withAnimation(.easeIn) {
            removeSelectedCoin()
        }
        
        UIApplication.shared.endEditing()
    }
    
    func removeSelectedCoin() {
        vm.selectedCoin = nil
        quantityText = ""
        vm.searchText = ""
    }
}

#Preview {
    PortfolioTransactionView(quantityText: .constant(""))
        .environmentObject(HomeViewModel())
}
