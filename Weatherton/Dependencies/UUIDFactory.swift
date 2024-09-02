//
//  UUIDFactory.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/30/24.
//

import Foundation

final class UUIDFactory {
    private let closure: () -> UUID

    init(_ closure: @escaping () -> UUID) {
        self.closure = closure
    }

    /// Generates a `UUID`.
    func uuid() -> UUID {
        closure()
    }
}
