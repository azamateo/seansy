//
//  KinoKZClient.swift
//  KinoKZ_APP
//
//  Created by Azamat Murtazin on 22.04.2024.
//

import Foundation

final class KinoKZApiClient: APIClient, @unchecked Sendable {

    private let baseURL: URL
    private let httpClient: any HTTPClient
    private let serialiser: any Serialiser

    init(
        baseURL: URL,
        httpClient: some HTTPClient,
        serialiser: some Serialiser
    ){
        self.baseURL = baseURL
        self.httpClient = httpClient
        self.serialiser = serialiser
    }

    func get<Response: Decodable>(path: URL) async throws -> Response {
        let url = urlFromPath(path)
        let headers = [
            "Accept": "application/json"
        ]

        let request = HTTPRequest(url: url, headers: headers)
        let responseObject: Response = try await perform(request: request)

        return responseObject
    }

    func post<Response: Decodable>(path: URL, body: some Encodable) async throws -> Response {
        let url = urlFromPath(path)
        let headers = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        let data: Data
        do {
            data = try await serialiser.encode(body)
        } catch let error {
            throw KinoKZApiError.encode(error)
        }

        let request = HTTPRequest(url: url, method: .post, headers: headers, body: data)
        let responseObject: Response = try await perform(request: request)

        return responseObject
    }

    func delete<Response: Decodable>(path: URL, body: some Encodable) async throws -> Response {
        let url = urlFromPath(path)
        let headers = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        let data: Data
        do {
            data = try await serialiser.encode(body)
        } catch let error {
            throw KinoKZApiError.encode(error)
        }

        let request = HTTPRequest(url: url, method: .delete, headers: headers, body: data)
        let responseObject: Response = try await perform(request: request)

        return responseObject
    }

}

extension KinoKZApiClient {

    private func perform<Response: Decodable>(request: HTTPRequest) async throws -> Response {
        let response: HTTPResponse

        do {
            response = try await httpClient.perform(request: request)
        } catch let error {
            throw KinoKZApiError.network(error)
        }

        let decodedResponse: Response = try await decodeResponse(response: response)

        return decodedResponse
    }

    private func urlFromPath(_ path: URL) -> URL {
        guard var urlComponents = URLComponents(url: path, resolvingAgainstBaseURL: true) else {
            return path
        }
        
        urlComponents.scheme = baseURL.scheme
        urlComponents.host = baseURL.host
        urlComponents.path = "\(baseURL.path)\(urlComponents.path)"
        
        return urlComponents.url!
    }

    private func decodeResponse<Response: Decodable>(response: HTTPResponse) async throws -> Response {
        try await validate(response: response)

        guard let data = response.data else {
            throw KinoKZApiError.unknown
        }

        let decodedResponse: Response
        do {
            decodedResponse = try await serialiser.decode(Response.self, from: data)
        } catch let error {
            throw KinoKZApiError.decode(error)
        }

        return decodedResponse
    }

    private func validate(response: HTTPResponse) async throws {
        let statusCode = response.statusCode
        if (200 ... 299).contains(statusCode) {
            return
        }

        guard let data = response.data 
        else {
            throw KinoKZApiError(statusCode: statusCode, message: nil)
        }

        let statusResponse = try? await serialiser.decode(KinoKZStatusResponse.self, from: data)
        let message = statusResponse?.statusMessage

        throw KinoKZApiError(statusCode: statusCode, message: message)
    }

}
