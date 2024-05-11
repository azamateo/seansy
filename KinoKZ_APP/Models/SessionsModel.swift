//
//  MoviesSessionsModel.swift
//  KinoKZ_APP
//
//  Created by Azamat Murtazin on 05.05.2024.
//

import Foundation

struct MoviesSessionModel: Codable {
    let result: SessionsResult
    
    struct SessionsResult: Codable {
        let sessions: [SessionsModel]
    }
}



public struct SessionsModel: Codable {
    let session: Session
    let hall: Hall
    let cinema: Cinema
//    let sessions: [session_, cinema_, hall_]
}

public struct Session: Identifiable, Codable, Equatable, Hashable, Sendable {
    public let id: Int
    public let cinema_id : Int
    public let hall_id : Int
    public let session_type : Int
    public let lang_id : Int
    public let lang_label : String
    public let is_3_d : Bool
    public let adult_price : Int
    public let child_price : Int
    public let vip_price : Int
    public let session_date : String
    public let session_date_tz : String
    public let is_atmos : Bool
    public let is_reald : Bool
    public let hour : String
    public let minutes : String
    public let is_atmos3d : Bool
    public let is_imax: Bool
    public let is_fdx: Bool
    public let session_id: Int
    public let sub_session_type: Int
    
    public init(
        id: Int,
        cinema_id : Int,
        hall_id : Int,
        session_type : Int,
        lang_id : Int,
        lang_label : String,
        is_3_d : Bool,
        adult_price : Int,
        child_price : Int,
        vip_price : Int,
        session_date : String,
        session_date_tz : String,
        is_atmos : Bool,
        is_reald : Bool,
        hour : String,
        minutes : String,
        is_atmos3d : Bool,
        is_imax: Bool,
        is_fdx: Bool,
        session_id: Int,
        sub_session_type: Int
    ){
        self.id = id
        self.cinema_id = cinema_id
        self.hall_id = hall_id
        self.session_type = session_type
        self.lang_id = lang_id
        self.lang_label = lang_label
        self.is_3_d = is_3_d
        self.adult_price = adult_price
        self.child_price = child_price
        self.vip_price = vip_price
        self.session_date = session_date
        self.session_date_tz = session_date_tz
        self.is_atmos = is_atmos
        self.is_reald = is_reald
        self.hour = hour
        self.minutes = minutes
        self.is_atmos3d = is_atmos3d
        self.is_imax = is_imax
        self.is_fdx = is_fdx
        self.session_id = session_id
        self.sub_session_type = sub_session_type
    }

}

extension Session {
    private enum CodingKeys: String, CodingKey {
        case id
        case cinema_id
        case hall_id
        case session_type
        case lang_id
        case lang_label
        case is_3_d
        case adult_price = "adult"
        case child_price = "child"
        case vip_price = "vip"
        case session_date
        case session_date_tz
        case is_atmos
        case is_reald
        case hour
        case minutes
        case is_atmos3d
        case is_imax
        case is_fdx
        case session_id
        case sub_session_type

    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.cinema_id = try container.decode(Int.self, forKey: .cinema_id)
        self.hall_id = try container.decode(Int.self, forKey: .hall_id)
        self.session_type = try container.decode(Int.self, forKey: .session_type)
        self.lang_id = try container.decode(Int.self, forKey: .lang_id)
        self.lang_label = try container.decode(String.self, forKey: .lang_label)
        self.is_3_d = try container.decode(Bool.self, forKey: .is_3_d)
        self.adult_price = try container.decode(Int.self, forKey: .adult_price)
        self.child_price = try container.decode(Int.self, forKey: .child_price)
        self.vip_price = try container.decode(Int.self, forKey: .vip_price)
        self.session_date = try container.decode(String.self, forKey: .session_date)
        self.session_date_tz = try container.decode(String.self, forKey: .session_date_tz)
        self.is_atmos = try container.decode(Bool.self, forKey: .is_atmos)
        self.is_reald = try container.decode(Bool.self, forKey: .is_reald)
        self.hour = try container.decode(String.self, forKey: .hour)
        self.minutes = try container.decode(String.self, forKey: .minutes)
        self.is_atmos3d = try container.decode(Bool.self, forKey: .is_atmos3d)
        self.is_imax = try container.decode(Bool.self, forKey: .is_imax)
        self.is_fdx = try container.decode(Bool.self, forKey: .is_fdx)
        self.session_id = try container.decode(Int.self, forKey: .session_id)
        
        self.sub_session_type = try container.decode(Int.self, forKey: .sub_session_type)
        
    }

}
