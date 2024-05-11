//
//  URLSessionHTTPClientAdapter.swift
//  KinoKZ_APP
//
//  Created by Azamat Murtazin on 22.04.2024.
//

import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

final class URLSessionHTTPClientAdapter: HTTPClient {

    private let urlSession: URLSession

    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }

    func perform(request: HTTPRequest) async throws -> HTTPResponse {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        for header in request.headers {
            urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
        }

        let data: Data
        let response: URLResponse

        do {
            (data, response) = try await perform(urlRequest)
        } catch let error {
            throw error
        }

        guard let httpURLResponse = response as? HTTPURLResponse else {
            return HTTPResponse(statusCode: -1, data: nil)
        }

        let statusCode = httpURLResponse.statusCode
        return HTTPResponse(statusCode: statusCode, data: data)
    }

}

extension URLSessionHTTPClientAdapter {

    #if canImport(FoundationNetworking)
        private func perform(_ urlRequest: URLRequest) async throws -> (Data, URLResponse) {
            try await withCheckedThrowingContinuation { continuation in
                urlSession.dataTask(with: urlRequest) { data, response, error in
                    if let error {
                        continuation.resume(throwing: error)
                        return
                    }

                    guard let data, let response else {
                        continuation.resume(throwing: NSError(domain: "kz.kino", code: -1))
                        return
                    }

                    continuation.resume(returning: (data, response))
                }
                .resume()
            }
        }
    #else
        private func perform(_ urlRequest: URLRequest) async throws -> (Data, URLResponse) {
            try await urlSession.data(for: urlRequest)
        }
    #endif

}
