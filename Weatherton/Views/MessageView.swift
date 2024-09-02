//
//  MessageView.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 9/1/24.
//

import SwiftUI

struct MessageView: View {
    let message: Message

    var body: some View {
        Label(message.description, systemImage: message.systemImage)
            .fontWeight(.semibold)
            .foregroundStyle(message.foregroundStyle)
            .padding(.horizontal, 40)
            .padding(.vertical, 12)
            .background(.thickMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

#Preview {
    MessageView(message: .notConnectedToInternet)
}

enum Message {
    case notConnectedToInternet

    var description: String {
        switch self {
        case .notConnectedToInternet: Strings.notConnectedToInternet
        }
    }

    var systemImage: String {
        switch self {
        case .notConnectedToInternet: "network.slash"
        }
    }

    var foregroundStyle: some ShapeStyle {
        switch self {
        case .notConnectedToInternet: Color.red
        }
    }
}
