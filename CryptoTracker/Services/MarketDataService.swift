//
//  MarketDataService.swift
//  CryptoTracker
//
//  Created by Anton Tropin on 30.10.23.
//

import Foundation
import Combine

final class MarketDataService {
    
    @Published var marketData: MarketData? = nil
    var marketDataSubscription: AnyCancellable?
    
    private var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    init() { getData() }
    
    func getData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global?x_cg_demo_api_key=CG-62mQEWwyuzHtkNow7LiyR77Z") else { return }
        
        marketDataSubscription = NetworkManager.download(url: url)
            .decode(type: GlobalData.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: NetworkManager.handleCompletion,
                receiveValue: { [weak self] globalData in
                    self?.marketData = globalData.data
                    self?.marketDataSubscription?.cancel()
                }
            )
    }
}
