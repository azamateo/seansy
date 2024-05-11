//
//  HallModel.swift
//  KinoKZ_APP
//
//  Created by Azamat Murtazin on 05.05.2024.
//

import Foundation

public struct Hall: Codable {
    public let id: Int
    public let cinema_id: Int
    public let name: String
    public let name_parser: String
    public let color: String
    public let imax: Bool
    public let fdx: Bool
    public let laser: Bool
    public let state: Bool
    public let hall_order: Int
    public let provider_id: Int
    public let name_i18n: [String: String]
    public let color_i18n: [String: String]

    public init(
        id: Int,
        cinema_id: Int,
        name: String,
        name_parser: String,
        color: String,
        imax: Bool,
        fdx: Bool,
        laser: Bool,
        state: Bool,
        hall_order: Int,
        provider_id: Int,
        name_i18n: [String: String],
        color_i18n: [String: String]
    ) {
        self.id = id
        self.cinema_id = cinema_id
        self.name = name
        self.name_parser = name_parser
        self.color = color
        self.imax = imax
        self.fdx = fdx
        self.laser = laser
        self.state = state
        self.hall_order = hall_order
        self.provider_id = provider_id
        self.name_i18n = name_i18n
        self.color_i18n = color_i18n
    }
}

extension Hall {
    private enum CodingKeys: String, CodingKey {
        case id
        case cinema_id
        case name
        case name_parser
        case color
        case imax
        case fdx
        case laser
        case state
        case hall_order
        case provider_id
        case name_i18n
        case color_i18n
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.cinema_id = try container.decode(Int.self, forKey: .cinema_id)
        self.name = try container.decode(String.self, forKey: .name)
        self.name_parser = try container.decode(String.self, forKey: .name_parser)
        self.color = try container.decode(String.self, forKey: .color)
        self.imax = try container.decode(Bool.self, forKey: .imax)
        self.fdx = try container.decode(Bool.self, forKey: .fdx)
        self.laser = try container.decode(Bool.self, forKey: .laser)
        self.state = try container.decode(Bool.self, forKey: .state)
        self.hall_order = try container.decode(Int.self, forKey: .hall_order)
        self.provider_id = try container.decode(Int.self, forKey: .provider_id)
        self.name_i18n = try container.decode([String: String].self, forKey: .name_i18n)
        self.color_i18n = try container.decode([String: String].self, forKey: .color_i18n)
    }
}
