//
//  Design.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 9/1/24.
//

import SwiftUI

enum Design {}

extension Design {
    enum Sizing {
        static let reducedMinimum = CGFloat(32)
        static let standardMinimum = CGFloat(44)
        static let temperatureBarHeight = CGFloat(6)
    }

    enum Spacing {
        static let ultraSmall = CGFloat(4)
        static let verySmall = CGFloat(8)
        static let small = CGFloat(12)
        static let reduced = CGFloat(16)
        static let standard = CGFloat(20)
        static let veryLarge = CGFloat(40)
    }

    enum ClipShape {
        static let standardRoundedRectangle = RoundedRectangle(cornerRadius: 12, style: .continuous)
    }

    enum Color {
        static let transparentGray = SwiftUI.Color.gray.opacity(0.25)
        static let transparentBlack = SwiftUI.Color.black.opacity(0.25)
    }

    enum Font {
        static let veryLarge = SwiftUI.Font.system(size: 48)
        static let ultraLarge = SwiftUI.Font.system(size: 64)
    }

    enum Radius {
        static let standard = CGFloat(12)
    }
}
