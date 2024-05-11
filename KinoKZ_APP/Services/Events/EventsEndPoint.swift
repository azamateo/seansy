//
//  ConcertsEndpoint.swift
//  KinoKZ_APP
//
//  Created by Azamat Murtazin on 28.04.2024.
//

import Foundation

enum EventsEndPoint {
    case eventsList(cityId: Int, startDate: String, endDate: String, eventType: String)
}

extension EventsEndPoint: Endpoint {
    
    private static let basePath = URL(string: "event-pub/pub/v1/events/find")!

    var path: URL {
        switch self {
        case .eventsList(let cityId, let startDate, let endDate, let eventType):
            return  Self.basePath.appending(queryItems: [URLQueryItem(name: "city_id", value: "\(cityId)"), URLQueryItem(name: "start_date", value: "\(startDate)"),  URLQueryItem(name: "end_date", value: "\(endDate)"), URLQueryItem(name: "event_type_name", value: "\(eventType)")])
        }
    }
}
