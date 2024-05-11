//
//  KinoKZApiError.swift
//  KinoKZ_APP
//
//  Created by Azamat Murtazin on 22.04.2024.
//

import Foundation


enum KinoKZApiError: Error {

    case network(Error)

    case badRequest(String?)

    case unauthorised(String?)

    case forbidden(String?)

    case notFound(String?)

    case methodNotAllowed(String?)

    case notAcceptable(String?)

    case unprocessableContent(String?)

    case tooManyRequests(String?)

    case internalServerError(String?)

    case notImplemented(String?)

    case badGateway(String?)

    case serviceUnavailable(String?)

    case gatewayTimeout(String?)

    case encode(Error)

    case decode(Error)

    case unknown

}
