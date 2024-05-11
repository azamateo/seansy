//
//  HTTPClient.swift
//  KinoKZ_APP
//
//  Created by Azamat Murtazin on 22.04.2024.
//

import Foundation

public protocol HTTPClient: Sendable {

    func perform(request: HTTPRequest) async throws -> HTTPResponse

}
