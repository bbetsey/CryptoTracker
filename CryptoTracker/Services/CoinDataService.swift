//
//  CoinDataService.swift
//  CryptoTracker
//
//  Created by Anton Tropin on 29.10.23.
//

import Foundation
import Combine

final class CoinDataService {
    
    @Published var allCoins: [Coin] = []
    var coinSubscription: AnyCancellable?
    
    private var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    init() { getCoins() }
    
    func getCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h&x_cg_demo_api_key=CG-62mQEWwyuzHtkNow7LiyR77Z") else { return }
        
        coinSubscription = NetworkManager.download(url: url)
            .decode(type: [Coin].self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: NetworkManager.handleCompletion,
                receiveValue: { [weak self] coins in
                    self?.allCoins = coins
                    self?.coinSubscription?.cancel()
                }
            )
    }
}
