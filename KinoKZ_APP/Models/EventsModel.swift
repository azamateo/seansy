//
//  EventModel.swift
//  KinoKZ_APP
//
//  Created by Azamat Murtazin on 28.04.2024.
//
//
//{
//    "message": "ok",
//    "result": [
//        {
//            "id": 5225,
//            "genres": null,
//            "partner_name": "Президентский центр Республики Казахстан",
//            "event_type_id": 3,
//            "name_add": "",
//            "name_origin": "Kalifarniya в Астане",
//            "name_rus": "KALI[ZONE] TOUR 2024 Астанада",
//            "name": "KALI[ZONE] TOUR 2024 Астанада",
//            "presentation": "",
//            "age_restriction": 0,
//            "premiere_kaz": "2024-06-16T00:00:00Z",
//            "premiere_kyr": null,
//            "premiere_rus": null,
//            "premiere_world": null,
//            "priority": 8,
//            "partner_city_id": 1,
//            "partner_city_name": "Астана",
//            "small_poster": "https://cdn.kino.kz/partners-events/KALIZONETOUR2024vAstane/p168x242.webp",
//            "event_type_name": "Концерт",
//            "partner_id": 428,
//            "lang_id": 1,
//            "partner_type_name": "Концерты",
//            "price_from": 8000,
//            "was_transfered": false
//        },
//        
//    ],
//    "status": true
//}
//

import Foundation

public struct EventsModel: Codable {
    let result: [Event]
}

public struct Event: Identifiable, Codable, Equatable, Hashable, Sendable {
    public let id : Int
    public let genres : String?
    public let partner_name: String?
    public let event_type_id: Int?
    public let name_add: String?
    public let name_origin:String?
    public let name_rus: String?
    public let name: String?
    public let presentation: String?
    public let age_restriction:Int?
    public let big_poster:String?
    public let premiere_kaz:String?
    public let premiere_kyr:String?
    public let premiere_rus:String?
    public let premiere_world:String?
    public let priority:Int?
    public let partner_city_id:Int?
    public let partner_city_name:String?
    public let small_poster:String?
    public let event_type_name:String?
    public let partner_id:Int?
    public let lang_id:Int?
    public let price_from: Int?
    public let was_transfered: Bool?
    
    public init(
        id : Int,
        genres : String? = nil,
        partner_name: String?,
        event_type_id: Int?,
        name_add: String?,
        name_origin:String?,
        name_rus: String?,
        name: String?,
        presentation: String?,
        age_restriction:Int?,
        big_poster:String?,
        premiere_kaz:String?,
        premiere_kyr:String?,
        premiere_rus:String?,
        premiere_world:String?,
        priority:Int?,
        partner_city_id:Int?,
        partner_city_name:String?,
        small_poster:String?,
        event_type_name:String?,
        partner_id:Int?,
        lang_id:Int?,
        price_from: Int?,
        was_transfered: Bool?
    ){
        self.id = id
        self.genres = genres
        self.partner_name = partner_name
        self.event_type_id = event_type_id
        self.name_add = name_add
        self.name_origin = name_origin
        self.name_rus = name_rus
        self.name = name
        self.presentation = presentation
        self.age_restriction = age_restriction
        self.big_poster = big_poster
        self.premiere_kaz = premiere_kaz
        self.premiere_kyr = premiere_kyr
        self.premiere_rus = premiere_rus
        self.premiere_world = premiere_world
        self.priority = priority
        self.partner_city_id = partner_city_id
        self.partner_city_name = partner_city_name
        self.small_poster = small_poster
        self.event_type_name = event_type_name
        self.partner_id = partner_id
        self.lang_id = lang_id
        self.price_from = price_from
        self.was_transfered = was_transfered
    }
}

extension Event {
    private enum CodingKeys: String, CodingKey {
        case id
        case genres
        case partner_name
        case event_type_id
        case name_add
        case name_origin
        case name_rus
        case name
        case presentation
        case age_restriction
        case big_poster
        case premiere_kaz
        case premiere_kyr
        case premiere_rus
        case premiere_world
        case priority
        case partner_city_id
        case partner_city_name
        case small_poster
        case event_type_name
        case partner_id
        case lang_id
        case price_from
        case was_transfered
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.genres = try container.decodeIfPresent(String.self, forKey: .genres)
        self.partner_name = try container.decodeIfPresent(String.self, forKey: .partner_name)
        self.event_type_id = try container.decodeIfPresent(Int.self, forKey: .event_type_id)
        self.name_add = try container.decodeIfPresent(String.self, forKey: .name_add)
        self.name_origin = try container.decodeIfPresent(String.self, forKey: .name_origin)
        self.name_rus = try container.decodeIfPresent(String.self, forKey: .name_rus)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.presentation = try container.decodeIfPresent(String.self, forKey: .presentation)
        self.age_restriction = try container.decodeIfPresent(Int.self, forKey: .age_restriction)
        self.big_poster = try container.decodeIfPresent(String.self, forKey: .big_poster)
        self.premiere_kaz = try container.decodeIfPresent(String.self, forKey: .premiere_kaz)
        self.premiere_kyr = try container.decodeIfPresent(String.self, forKey: .premiere_kyr)
        self.premiere_rus = try container.decodeIfPresent(String.self, forKey: .premiere_rus)
        self.premiere_world = try container.decodeIfPresent(String.self, forKey: .premiere_world)
        self.priority = try container.decodeIfPresent(Int.self, forKey: .priority)
        self.partner_city_id = try container.decodeIfPresent(Int.self, forKey: .partner_city_id)
        self.partner_city_name = try container.decodeIfPresent(String.self, forKey: .partner_city_name)
        self.small_poster = try container.decodeIfPresent(String.self, forKey: .small_poster)
        self.event_type_name = try container.decodeIfPresent(String.self, forKey: .event_type_name)
        self.partner_id = try container.decodeIfPresent(Int.self, forKey: .partner_id)
        self.lang_id = try container.decodeIfPresent(Int.self, forKey: .lang_id)
        self.price_from = try container.decodeIfPresent(Int.self, forKey: .price_from)
        self.was_transfered = try container.decodeIfPresent(Bool.self, forKey: .was_transfered)
    }
}
