//
//  CardHeader.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/30/24.
//

import SwiftUI

struct CardHeader: View {
    let title: LocalizedStringKey
    let systemImage: String

    init(_ title: LocalizedStringKey, systemImage: String) {
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
    }
}

#Preview {
    CardHeader("Hourly Forecast", systemImage: "clocl")
}
