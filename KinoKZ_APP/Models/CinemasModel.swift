//
//  Cinema.swift
//  KinoKZ_APP
//
//  Created by Azamat Murtazin on 22.04.2024.

//"id": 144,
//      "name": "Chaplin MEGA Silk Way",
//      "address": "ТРЦ «MEGA Silk Way» (территория EXPO), 2-й этаж",
//      "latitude": "51.089046",
//      "longitude": "71.407983",
//      "phone": "После 22:00 несовершеннолетние могут находиться в кинотеатре только с родителями/опекунами при наличии документов на ребенка.",
//      "city_name": "Астана",
//      "city_id": 1,
//      "order": 20,
//      "state": 1,
//      "small_poster": "https://cdn.kino.kz/cinema/144/p223x267.jpg",
//      "big_poster": "https://cdn.kino.kz/cinema/144/p1000x1000.webp",
//      "info_up": "",
//      "description": "\u003Cb\u003EВнимание!\u003C/b\u003E Возврат билетов возможен до начала сеанса или до момента распечатки билета.\u003Cbr/\u003E\u003Cbr/\u003E\u003Cbr/\u003E\nОдиннадцатизальный кинотеатр нового поколения на 1830 мест. Общая площадь кинотеатра – пять с половиной тысяч квадратных метров.  Уникальность Chaplin в MEGA Silk Way в технологии RealD 3D, которая дает высокую четкость картинки, а также в размерах большого экрана – его высота достигает 12 метров, это самый большой экран в столице.\u003Cbr/\u003E\nВсе залы кинотеатра оборудованы звуковой системой Dolby, а в двух больших залах установлена система Dolby Atmos, создающая 3D акустическую картинку.\u003Cbr/\u003E\nВпервые в Казахстане мы реализовали идею автоматизированных терминалов по продаже билетов, которые сделают процесс покупки более быстрым, удобным и интерактивным.\u003Cbr/\u003E\nНовая система обслуживания гостей – зона self-service, где зрители смогут сами выбрать продукцию бара.\n\u003Cbr/\u003E\u003Cbr/\u003E\n3D-очки для просмотра фильмов в формате RealD приобретаются отдельно. Стоимость взрослых и детских 3D-очков - 200 тенге, клипса-насадка на очки с диоптриями стоит 500 тенге. Очки переходят в собственность гостя и могут быть использованы повторно.\n\u003Cbr/\u003E\u003Cbr/\u003E\n\u003Cb\u003EВ соответствии с Законом «О правах ребенка в Республике Казахстан» в ночное время (с 22:00 до 06:00 часов) запрещается нахождение несовершеннолетних детей (до 18 лет) в развлекательных заведениях без сопровождения законных представителей.\n\u003Cbr/\u003E\nДля детей билеты на сеансы, заканчивающиеся после 22.00, могут быть проданы только законным представителям ребенка и в присутствии его законного представителя.\n\u003Cbr/\u003E\nПожалуйста, учитывайте этот факт при планировании вашего досуга!\n\u003Cbr/\u003E\nДорогие родители! Если вы планируете посетить вечерние сеансы со своими детьми, пожалуйста, берите с собой свои документы и свидетельство о рождении ребенка.\u003C/b\u003E",
//      "info_state": "",
//      "provider_link": ""

import Foundation
public struct CinemaModel: Codable {
    let result: [Cinema]
}

public struct Cinema: Identifiable, Codable, Equatable, Hashable, Sendable {
    public let id : Int
    public let name : String
    public let latitude: Double?
    public let longitude: Double?
    public let phone: String?
    public let city_name:String?
    public let city_id: Int?
    public let order: Int?
    public let state: Int?
    public let small_poster:String?
    public let big_poster:String?
    public let info_up:String?
    public let description:String?
    public let info_state:String?
    public let provider_link:String?
    
    public init(
        id : Int,
        name : String,
        latitude: Double? = nil,
        longitude: Double? = nil,
        phone: String? = nil,
        city_name:String? = nil,
        city_id: Int,
        order: Int,
        state: Int,
        small_poster:String? = nil,
        big_poster:String? = nil,
        info_up:String? = nil,
        description:String? = nil,
        info_state:String? = nil,
        provider_link:String? = nil
    ){
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.phone = phone
        self.city_name = city_name
        self.city_id = city_id
        self.order = order
        self.state = state
        self.small_poster = small_poster
        self.big_poster = big_poster
        self.info_up = info_up
        self.description = description
        self.info_state = info_state
        self.provider_link = provider_link
    }
}

extension Cinema {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case latitude
        case longitude
        case phone
        case city_name
        case city_id
        case order
        case state
        case small_poster
        case big_poster
        case info_up
        case description
        case info_state
        case provider_link
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.latitude = try container.decodeIfPresent(Double.self, forKey: .latitude)
        self.longitude = try container.decodeIfPresent(Double.self, forKey: .longitude)
        self.phone = try container.decodeIfPresent(String.self, forKey: .phone)
        self.city_name = try container.decodeIfPresent(String.self, forKey: .city_name)
        self.city_id = try container.decodeIfPresent(Int.self, forKey: .city_id)
        self.order = try container.decodeIfPresent(Int.self, forKey: .order)
        self.state = try container.decodeIfPresent(Int.self, forKey: .state)
        self.small_poster = try container.decodeIfPresent(String.self, forKey: .small_poster)
        self.big_poster = try container.decodeIfPresent(String.self, forKey: .big_poster)
        self.info_up = try container.decodeIfPresent(String.self, forKey: .info_up)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.info_state = try container.decodeIfPresent(String.self, forKey: .info_state)
        self.provider_link = try container.decodeIfPresent(String.self, forKey: .provider_link)
    }
}
