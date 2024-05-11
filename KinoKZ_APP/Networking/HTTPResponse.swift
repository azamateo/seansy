//
//  HTTPResponse.swift
//  KinoKZ_APP
//
//  Created by Azamat Murtazin on 22.04.2024.
//

import Foundation

public struct HTTPResponse: Sendable {

    public let statusCode: Int

    public let data: Data?

    public init(statusCode: Int = 200, data: Data? = nil) {
        self.statusCode = statusCode
        self.data = data
    }

}
