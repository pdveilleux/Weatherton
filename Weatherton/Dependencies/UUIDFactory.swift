//
//  UUIDFactory.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/30/24.
//

import Foundation

final class UUIDFactory {
    let closure: () -> UUID

    init(_ closure: @escaping () -> UUID) {
        self.closure = closure
    }

    func uuid() -> UUID {
        closure()
    }
}
