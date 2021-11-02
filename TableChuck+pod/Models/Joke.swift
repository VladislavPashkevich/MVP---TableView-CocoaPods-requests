//
//  Joke.swift
//  TableChuck+pod
//
//  Created by Vladislav Pashkevich on 2.11.21.
//

import Foundation

struct Joke: Codable {
    let iconURL: String
    let value: String
    
    enum CodingKeys: String, CodingKey {
        case iconURL = "icon_url"
        case value
    }
}
