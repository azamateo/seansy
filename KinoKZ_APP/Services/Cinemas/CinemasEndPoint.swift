//
//  CinemasEndPoint.swift
//  KinoKZ_APP
//
//  Created by Azamat Murtazin on 22.04.2024.
//

import Foundation

enum CinemasEndPoint {
    case cinemasList(cityId: Int)
}

extension CinemasEndPoint: Endpoint {
    
    private static let basePath = URL(string: "catalog/v1/cinemas")!

    var path: URL {
        switch self {
        case .cinemasList(let cityId):
            return  Self.basePath.appending(queryItems: [URLQueryItem(name: "city", value: "\(cityId)")])//.appendingPathComponent("\(cityId)")
        }
    }
}
