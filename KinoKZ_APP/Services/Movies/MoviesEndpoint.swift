//
//  MoviesEndpoint.swift
//  KinoKZ_APP
//
//  Created by Azamat Murtazin on 28.04.2024.
//

import Foundation

enum MoviesEndpoint {
    case moviesList(cityid: Int, startdate: String, enddate: String)
}

extension MoviesEndpoint: Endpoint {
    
    private static let basePath = URL(string: "sessions/v1/movies/find")!
//    var body: MoviesRequestModel{
//        switch self{
//        case .moviesList(let cityid,let startdate, let enddate):
//            return MoviesRequestModel(city_id: cityid, end_date: startdate, start_date: enddate)
//        }
//    }
    var path: URL {
        switch self{
            case.moviesList:
            return MoviesEndpoint.basePath//.appendingPathComponent("sessions/v1/movies/find")
        }
    }

}
