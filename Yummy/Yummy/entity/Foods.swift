//
//  Foods.swift
//  Yummy
//
//  Created by varol on 11.01.2022.
//

import Foundation

struct Foods: Codable {
    let foodId: String?
    let foodName: String?
    let foodImageName: String?
    let foodPrice: String?
    
    enum CodingKeys: String, CodingKey {
        case foodId = "yemek_id"
        case foodName = "yemek_adi"
        case foodImageName = "yemek_resim_adi"
        case foodPrice = "yemek_fiyat"
    }
}
