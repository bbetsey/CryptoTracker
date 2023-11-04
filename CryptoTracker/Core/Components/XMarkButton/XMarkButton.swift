//
//  XMarkButton.swift
//  CryptoTracker
//
//  Created by Anton Tropin on 30.10.23.
//

import SwiftUI

struct XMarkButton: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var vm: HomeViewModel
    
    var body: some View {
        Button {
            vm.selectedCoin = nil
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
        }
    }
}

#Preview {
    XMarkButton()
}
