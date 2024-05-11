//
//  APIClient.swift
//  KinoKZ_APP
//
//  Created by Azamat Murtazin on 22.04.2024.
//

import Foundation

protocol APIClient {

    func get<Response: Decodable>(path: URL) async throws -> Response

    func post<Response: Decodable>(path: URL, body: some Encodable) async throws -> Response

    func delete<Response: Decodable>(path: URL, body: some Encodable) async throws -> Response

}

extension APIClient {

    func get<Response: Decodable>(endpoint: Endpoint) async throws -> Response {
        try await get(path: endpoint.path)
    }

    func post<Response: Decodable>(endpoint: Endpoint, body: some Encodable) async throws -> Response {
        try await post(path: endpoint.path, body: body)
    }

    func delete<Response: Decodable>(endpoint: Endpoint, body: some Encodable) async throws -> Response {
        try await delete(path: endpoint.path, body: body)
    }

}
