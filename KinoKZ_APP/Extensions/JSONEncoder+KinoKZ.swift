//
//  JSONEncoder+KinoKZ.swift
//  KinoKZ_APP
//
//  Created by Azamat Murtazin on 23.04.2024.
//

import Foundation


extension JSONEncoder {

    static var kinoKZ: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }

    static var kinoKZauth: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }

}
