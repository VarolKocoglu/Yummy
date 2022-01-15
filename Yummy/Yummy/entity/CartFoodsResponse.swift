//
//  CartFoodsResponse.swift
//  Yummy
//
//  Created by varol on 11.01.2022.
//

import Foundation

struct CartFoodsResponse: Codable {
    let allCartFoods: [CartFoods]?
    
    enum CodingKeys: String, CodingKey {
        case allCartFoods = "sepet_yemekler"
    }
}
