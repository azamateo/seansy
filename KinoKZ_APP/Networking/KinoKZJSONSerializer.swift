//
//  KinoKZ.swift
//  KinoKZ_APP
//
//  Created by Azamat Murtazin on 22.04.2024.
//

import Foundation

final class KinoKZJSONSerializer: Serialiser {

    init() {}

    func decode<T: Decodable>(_ type: T.Type, from data: Data) async throws -> T {
        let decoder = JSONDecoder.kinoKZ

        return try decoder.decode(type, from: data)
    }

    func encode(_ value: some Encodable) async throws -> Data {
        let encoder = JSONEncoder.kinoKZ

        return try encoder.encode(value)
    }

}
