//
//  CoinDetailService.swift
//  CryptoTracker
//
//  Created by Антон Тропин on 01.11.23.
//

import Foundation
import Combine

final class CoinDetailService {
    
    @Published var coinDetails: CoinDetail? = nil
    var coinSubscription: AnyCancellable?
    let coin: Coin
    
    private var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    init(coin: Coin) {
        self.coin = coin
        getCoinDetails()
    }
    
    func getCoinDetails() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false&x_cg_demo_api_key=CG-62mQEWwyuzHtkNow7LiyR77Z"
        ) else { return }
        
        coinSubscription = NetworkManager.download(url: url)
            .decode(type: CoinDetail.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: NetworkManager.handleCompletion,
                receiveValue: { [weak self] coinDetails in
                    self?.coinDetails = coinDetails
                    self?.coinSubscription?.cancel()
                }
            )
    }
}
