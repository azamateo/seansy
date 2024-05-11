//
//  SessionService.swift
//  KinoKZ_APP
//
//  Created by Azamat Murtazin on 05.05.2024.
//

import Foundation

public final class SessionService {
    
    private let apiClient: any APIClient
    
    public convenience init(configuration: KinoKZConfiguration) {
        self.init(
            apiClient: KinoKZFactory.apiClient(configuration: configuration)
        )
    }
    
    init(apiClient: some APIClient) {
        self.apiClient = apiClient
    }
    
    public func list(movie_id: Int, date: String, city_id: Int) async throws -> [SessionsModel] {
        let mainSession: MoviesSessionModel = try await apiClient.get(endpoint: SessionsEndPoint.sessionsList(movie_id: movie_id, date: date, city_id: city_id))
        
        return mainSession.result.sessions
    }
}
