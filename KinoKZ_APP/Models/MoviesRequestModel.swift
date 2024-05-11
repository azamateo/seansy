//
//  RequestModel.swift
//  KinoKZ_APP
//
//  Created by Azamat Murtazin on 28.04.2024.
//

import Foundation

struct MoviesRequestModel: Encodable, Equatable {
    let city_id: Int
    let end_date: String
    let start_date: String
}
