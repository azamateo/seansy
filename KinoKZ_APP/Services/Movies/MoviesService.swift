//
//  MoviesService.swift
//  KinoKZ_APP
//
//  Created by Azamat Murtazin on 28.04.2024.
//

import Foundation

public final class MoviesService {
    
    private let apiClient: any APIClient
    
    public convenience init(configuration: KinoKZConfiguration) {
        self.init(
            apiClient: KinoKZFactory.apiClient(configuration: configuration)
        )
    }
    
    init(apiClient: some APIClient) {
        self.apiClient = apiClient
    }
    
    public func list(cityId: Int, startDate: String, endDate: String) async throws -> MoviesModel {
        let body = MoviesRequestModel(city_id: cityId, end_date: endDate, start_date: startDate)
        let endPoint = MoviesEndpoint.moviesList(cityid: cityId, startdate: startDate, enddate: endDate)
        let movie: MoviesModel = try await apiClient.post(path: endPoint.path, body: body)
        return movie
    }
}
