//
//  URL+KinoKZ.swift
//  KinoKZ_APP
//
//  Created by Azamat Murtazin on 22.04.2024.
//

import Foundation

extension URL {
    
    static var kinoKZApiBaseURL: URL {
        URL(string: "https://api.kino.kz/")!
    }
    
    static var kinoKZwebsiteURL: URL {
        URL(string: "https://www.kino.kz")!
    }
}

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
