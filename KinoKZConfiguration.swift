//
//  KinoKZConfiguration.swift
//  KinoKZ_APP
//
//  Created by Azamat Murtazin on 22.04.2024.
//

import Foundation

public final class KinoKZConfiguration: Sendable {

    public let httpClient: any HTTPClient

    public convenience init() {
        self.init(
            httpClient: KinoKZFactory.defaultHTTPClientAdapter()
        )
    }

    public init(httpClient: some HTTPClient) {
        self.httpClient = httpClient
    }

}
