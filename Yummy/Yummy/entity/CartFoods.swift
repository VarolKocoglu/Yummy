//
//  CartFoods.swift
//  Yummy
//
//  Created by varol on 11.01.2022.
//

import Foundation

struct CartFoods: Codable {
    
    let cartFoodId: String?
    let foodName: String?
    let foodImageName: String?
    let foodPrice: String?
    let cartFoodNumber: String?
    let username: String?
    
    enum CodingKeys: String, CodingKey {
        case cartFoodId = "sepet_yemek_id"
        case foodName = "yemek_adi"
        case foodImageName = "yemek_resim_adi"
        case foodPrice = "yemek_fiyat"
        case cartFoodNumber = "yemek_siparis_adet"
        case username = "kullanici_adi"
    }
    
    
    
}
