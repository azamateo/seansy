//
//  ConcertsService.swift
//  KinoKZ_APP
//
//  Created by Azamat Murtazin on 28.04.2024.
//

import Foundation

public final class EventsService {
    
    private let apiClient: any APIClient
    
    public convenience init(configuration: KinoKZConfiguration) {
        self.init(
            apiClient: KinoKZFactory.apiClient(configuration: configuration)
        )
    }
    
    init(apiClient: some APIClient) {
        self.apiClient = apiClient
    }
    
    public func list(cityId: Int, startDate: String, endDate: String, eventType: String) async throws -> EventsModel {
        let events: EventsModel = try await apiClient.get(endpoint: EventsEndPoint.eventsList(cityId: cityId, startDate: startDate, endDate: endDate, eventType: eventType))
        return events
    }
}
