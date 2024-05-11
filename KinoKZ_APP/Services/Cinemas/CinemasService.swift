//
//  MovieService.swift
//  KinoKZ_APP
//
//  Created by Azamat Murtazin on 22.04.2024.
//

import Foundation

public final class CinemasService {
    
    private let apiClient: any APIClient
    
    public convenience init(configuration: KinoKZConfiguration) {
        self.init(
            apiClient: KinoKZFactory.apiClient(configuration: configuration)
        )
    }
    
    init(apiClient: some APIClient) {
        self.apiClient = apiClient
    }
    
    public func list(cityId: Int) async throws -> CinemaModel {
        let cinemas: CinemaModel = try await apiClient.get(endpoint: CinemasEndPoint.cinemasList(cityId: cityId))
        return cinemas
    }
}
