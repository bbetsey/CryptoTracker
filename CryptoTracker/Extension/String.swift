//
//  String.swift
//  CryptoTracker
//
//  Created by Антон Тропин on 01.11.23.
//

import Foundation

extension String {
    var removingHTMLOccurances: String {
        self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }
}
