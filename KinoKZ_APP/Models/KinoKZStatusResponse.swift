//
//  KinoKZStatusResponse.swift
//  KinoKZ_APP
//
//  Created by Azamat Murtazin on 22.04.2024.
//

import Foundation

struct KinoKZStatusResponse: Decodable, Sendable {

    let success: Bool
    let statusCode: Int
    let statusMessage: String

}
