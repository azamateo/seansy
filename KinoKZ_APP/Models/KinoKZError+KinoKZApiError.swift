//
//  KinoKZError+KinoKZApiError.swift
//  KinoKZ_APP
//
//  Created by Azamat Murtazin on 22.04.2024.
//

import Foundation

extension KinoKZError {

    init(error: some Error) {
        guard let apiError = error as? KinoKZApiError else {
            self = .unknown
            return
        }

        switch apiError {
        case .notFound:
            self = .notFound

        case let .unauthorised(message):
            self = .unauthorised(message)

        case let .network(error):
            self = .network(error)

        default:
            self = .unknown
        }
    }

}
