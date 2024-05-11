//
//  MoviesModel.swift
//  KinoKZ_APP
//
//  Created by Azamat Murtazin on 28.04.2024.
//

//{
//    "is_cache": true,
//    "message": "ok",
//    "result": [
//        {
//            "id": 10698,
//            "name": "Министерство неджентльменских дел",
//            "name_rus": "Министерство неджентльменских дел",
//            "name_origin": "The Ministry of Ungentlemanly Warfare",
//            "presentation": "",
//            "rating": 8.62,
//            "rating_state": true,
//            "age_restriction": 18,
//            "genre": "",
//            "genres": [
//                {
//                    "id": 8,
//                    "title": "боевик",
//                    "title_kz": "",
//                    "title_eng": "action movie"
//                },
//                {
//                    "id": 10,
//                    "title": "военный",
//                    "title_kz": "",
//                    "title_eng": "military"
//                },
//                {
//                    "id": 15,
//                    "title": "драма",
//                    "title_kz": "",
//                    "title_eng": "drama"
//                },
//                {
//                    "id": 16,
//                    "title": "история",
//                    "title_kz": "",
//                    "title_eng": "history"
//                }
//            ],
//            "premiere_kaz": "2024-04-25T00:00:00Z",
//            "s": "https://cdn.kino.kz/movies/The_Ministry_of_Ungentlemanly_Warfare/p168x242.webp",
//            "priority": 10,
//            "session_id": 16593373
//        },
//        {
//            "id": 10690,
//            "name": "Солай болып қалды",
//            "name_rus": "Солай болып қалды",
//            "name_origin": "Solay bolyp kaldy",
//            "presentation": "",
//            "rating": 8.95,
//            "rating_state": true,
//            "age_restriction": 14,
//            "genre": "",
//            "genres": [
//                {
//                    "id": 17,
//                    "title": "комедия",
//                    "title_kz": "",
//                    "title_eng": "comedy"
//                },
//                {
//                    "id": 36,
//                    "title": "романтика",
//                    "title_kz": "",
//                    "title_eng": "romance"
//                }
//            ],
//            "premiere_kaz": "2024-04-25T00:00:00Z",
//            "small_poster": "https://cdn.kino.kz/movies/Solay_bolyp_kaldy/p168x242.webp",
//            "priority": 9,
//            "session_id": 16637581
//        }
//    ]}



import Foundation

public struct MoviesModel: Codable {
    let result: [Movie]
}

public struct Movie: Identifiable, Codable, Equatable, Hashable, Sendable {
    
    public let id : Int
    public let name : String?
    public let name_rus: String?
    public let name_origin: String?
    public let presentation: String?
    public let rating: Float?
    public let rating_state: Bool?
    public let age_restriction: Int?
    public let genre:String?
    public let genres: [Genre]?
    public let premiere_kaz:String?
    public let small_poster:String?
    public let priority: Int?
    public let session_id: Int
    
    public init(
        
        id : Int,
        name : String,
        name_rus: String,
        name_origin: String,
        presentation: String,
        rating: Float,
        rating_state: Bool,
        age_restriction: Int,
        genre:String,
        genres:[Genre],
        premiere_kaz:String,
        small_poster:String,
        priority: Int,
        session_id: Int
    ){
        self.id = id
        self.name = name
        self.name_rus = name_rus
        self.name_origin = name_origin
        self.presentation = presentation
        self.rating = rating
        self.rating_state = rating_state
        self.age_restriction = age_restriction
        self.genre = genre
        self.genres = genres
        self.premiere_kaz = premiere_kaz
        self.small_poster = small_poster
        self.priority = priority
        self.session_id = session_id
    }
}

extension Movie {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case name_rus
        case name_origin
        case presentation
        case rating
        case rating_state
        case age_restriction
        case genre
        case genres
        case premiere_kaz
        case small_poster
        case priority
        case session_id
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.name_rus = try container.decodeIfPresent(String.self, forKey: .name_rus)
        self.name_origin = try container.decodeIfPresent(String.self, forKey: .name_origin)
        self.presentation = try container.decodeIfPresent(String.self, forKey: .presentation)
        self.rating = try container.decodeIfPresent(Float.self, forKey: .rating)
        self.rating_state = try container.decodeIfPresent(Bool.self, forKey: .rating_state)
        self.age_restriction = try container.decodeIfPresent(Int.self, forKey: .age_restriction)
        self.genre = try container.decodeIfPresent(String.self, forKey: .genre)
        self.genres = try container.decodeIfPresent([Genre].self, forKey: .genres)
        self.small_poster = try container.decodeIfPresent(String.self, forKey: .small_poster)
        self.premiere_kaz = try container.decodeIfPresent(String.self, forKey: .premiere_kaz)
        self.priority = try container.decodeIfPresent(Int.self, forKey: .priority)
        self.session_id = try container.decodeIfPresent(Int.self, forKey: .session_id)!
        
    }
}

public struct Genre: Identifiable, Codable, Equatable, Hashable, Sendable {
    public let id : Int
    public let title : String?
    public let title_kz : String?
    public let title_eng: String?
    
    public init(
        id : Int,
        title : String,
        title_kz: String,
        title_eng: String
    ){
        self.id = id
        self.title = title
        self.title_kz = title_kz
        self.title_eng = title_eng
    }

}
extension Genre {
    private enum CodingKeys: String, CodingKey{
        case id
        case title
        case title_kz
        case title_eng
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.title_kz = try container.decodeIfPresent(String.self, forKey: .title_kz)
        self.title_eng = try container.decodeIfPresent(String.self, forKey: .title_eng)
        
    }
}
