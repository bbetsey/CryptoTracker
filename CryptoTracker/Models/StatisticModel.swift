//
//  StatisticModel.swift
//  CryptoTracker
//
//  Created by Anton Tropin on 30.10.23.
//

import Foundation

struct Statistic: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
    
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}

extension Statistic {
    static var stat1 = Statistic(title: "Market Cap", value: "12.5Bn", percentageChange: 25.34)
    static var stat2 = Statistic(title: "Market Cap", value: "12.5Bn")
    static var stat3 = Statistic(title: "Market Cap", value: "12.5Bn", percentageChange: -12.34)
}
