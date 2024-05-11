//
//  HTTPrequest.swift
//  KinoKZ_APP
//
//  Created by Azamat Murtazin on 22.04.2024.
//

import Foundation


public struct HTTPRequest: Sendable {

    public let url: URL
    public let method: HTTPRequest.Method
    public let headers: [String: String]
    public let body: Data?

    public init(
        url: URL,
        method: HTTPRequest.Method = .get,
        headers: [String: String] = [:],
        body: Data? = nil
    ) {
        self.url = url
        self.method = method
        self.headers = headers
        self.body = body
    }

}

public extension HTTPRequest {

    enum Method: String, Sendable {
        case get = "GET"
        case post = "POST"
        case delete = "DELETE"
    }

}
