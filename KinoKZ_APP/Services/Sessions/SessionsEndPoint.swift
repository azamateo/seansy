//
//  SessionsEndPoint.swift
//  KinoKZ_APP
//
//  Created by Azamat Murtazin on 05.05.2024.
//

import Foundation

enum SessionsEndPoint {
    case sessionsList(movie_id: Int, date: String, city_id: Int)
}

extension SessionsEndPoint: Endpoint {
    
    private static let basePath = URL(string: "sessions/v1/movie/sessions")!

    var path: URL {
        switch self {
        case .sessionsList(let movie_id, let date, let city_id):
            return  Self.basePath.appending(queryItems: [URLQueryItem(name: "city_id", value: "\(city_id)"), URLQueryItem(name: "date", value: "\(date)"),URLQueryItem(name: "movie_id", value: "\(movie_id)")  ])
        }
    }
}
