//
//  Serializer.swift
//  KinoKZ_APP
//
//  Created by Azamat Murtazin on 22.04.2024.
//

import Foundation

import Foundation

protocol Serialiser {

    func decode<T: Decodable>(_ type: T.Type, from data: Data) async throws -> T

    func encode(_ value: some Encodable) async throws -> Data

}
