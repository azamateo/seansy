//
//  KinoKZFactory.swift
//  KinoKZ_APP
//
//  Created by Azamat Murtazin on 22.04.2024.
//

import Foundation

#if canImport(FoundationNetworking)
    import FoundationNetworking

    extension URLSession: @unchecked Sendable {}

    extension URL: @unchecked Sendable {}
#endif

final class KinoKZFactory {

    private init() {}

}

extension KinoKZFactory {

    static func apiClient(configuration: KinoKZConfiguration) -> some APIClient {
        KinoKZApiClient(
            baseURL: kinokzAPIBaseURL,
            httpClient: configuration.httpClient,
            serialiser: serialiser()
        )
    }

}

extension KinoKZFactory {

    static func defaultHTTPClientAdapter() -> some HTTPClient {
        URLSessionHTTPClientAdapter(urlSession: urlSession)
    }

    private static let urlSession = URLSession(configuration: urlSessionConfiguration())

    private static func urlSessionConfiguration() -> URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        #if os(iOS)
            configuration.multipathServiceType = .handover
        #endif

        configuration.requestCachePolicy = .useProtocolCachePolicy
        configuration.timeoutIntervalForRequest = 30

        #if !canImport(FoundationNetworking)
            configuration.waitsForConnectivity = true
            configuration.urlCache = urlCache()
        #endif

        return configuration
    }

    #if !canImport(FoundationNetworking)
        private static func urlCache() -> URLCache {
            URLCache(memoryCapacity: 50_000_000, diskCapacity: 1_000_000_000)
        }
    #endif

    private static func serialiser() -> some Serialiser {
        KinoKZJSONSerializer()
    }

    private static func authSerialiser() -> some Serialiser {
        KinoKZJSONSerializer()
    }

}

extension KinoKZFactory {

    private static var kinokzAPIBaseURL: URL {
        URL.kinoKZApiBaseURL
    }

    private static var kinokzWebSiteURL: URL {
        URL.kinoKZwebsiteURL
    }

}
