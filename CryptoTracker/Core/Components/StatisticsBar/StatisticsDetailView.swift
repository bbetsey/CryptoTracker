//
//  StatisticsDetailView.swift
//  CryptoTracker
//
//  Created by Anton Tropin on 30.10.23.
//

import SwiftUI

struct StatisticsDetailView: View {
    
    let stat: Statistic
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(stat.title)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
            Text("$" + stat.value)
                .font(.callout.weight(.semibold))
        }
        .padding(.horizontal, 8)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    StatisticsDetailView(stat: Statistic.stat1)
        .preferredColorScheme(.dark)
}
