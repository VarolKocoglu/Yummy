//
//  FoodsResponse.swift
//  Yummy
//
//  Created by varol on 11.01.2022.
//

import Foundation

struct FoodsResponse: Codable {
    let foods: [Foods]?
    
    enum CodingKeys: String, CodingKey {
        case foods = "yemekler"
    }
}
