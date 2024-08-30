//
//  ErrorResponseModel.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/30/24.
//

import Foundation

struct ErrorResponseModel: Decodable {
    let error: Error
}

extension ErrorResponseModel {
    struct Error: Decodable {
        let message: String
        let code: Int
    }
}
