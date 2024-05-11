//
//  KinoKZError+KinoKZApiErrr.swift
//  KinoKZ_APP
//
//  Created by Azamat Murtazin on 22.04.2024.
//

import Foundation

public enum KinoKZError: Equatable, LocalizedError, Sendable {

    /// An error indicating the resource could not be found.
    case notFound

    case unauthorised(String?)

    /// An error indicating there was a network problem.
    case network(Error)

    /// An unknown error.
    case unknown

    public static func == (lhs: KinoKZError, rhs: KinoKZError) -> Bool {
        switch (lhs, rhs) {
        case (.notFound, .notFound):
            true

        case let (.unauthorised(lhsMessage), .unauthorised(rhsMessage)):
            lhsMessage == rhsMessage

        case (.network, .network):
            true

        case (.unknown, .unknown):
            true

        default:
            false
        }
    }

}

public extension KinoKZError {

    /// A localized message describing what error occurred.
    var errorDescription: String? {
        switch self {
        case .notFound:
            "Not found"

        case .unauthorised:
            "Unauthorised"

        case .network:
            "Network error"

        case .unknown:
            "Unknown"
        }
    }

}
