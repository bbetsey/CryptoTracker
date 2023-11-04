//
//  UIApplication.swift
//  CryptoTracker
//
//  Created by Anton Tropin on 30.10.23.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
