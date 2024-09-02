//
//  CardHeader.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/30/24.
//

import SwiftUI

struct CardHeader: View {
    let title: String
    let systemImage: String

    init(_ title: String, systemImage: String) {
        self.title = title
        self.systemImage = systemImage
    }

    var body: some View {
        VStack {
            Label(title, systemImage: systemImage)
                .textCase(.uppercase)
                .font(.caption)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
        }
        .accessibilityAddTraits(.isHeader)
    }
}

#Preview {
    CardHeader("Hourly Forecast", systemImage: "clock")
}
