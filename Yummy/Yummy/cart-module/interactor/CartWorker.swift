//
//  CartWorker.swift
//  Yummy
//
//  Created by varol on 13.01.2022.
//

import Foundation
import Alamofire

public let userDefaultNumbers: UserDefaults = UserDefaults.standard

class CartWorker {

    static func getAllFoods(username: String, handler: @escaping  (CartFoodsResponse) -> Void) {
        
        let params:Parameters = ["kullanici_adi": username]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php",method: .post, parameters: params).response { response in
            if let data = response.data {
                do{
                    let response = try JSONDecoder().decode(CartFoodsResponse.self, from: data)
                    handler(response)
                }catch{
                    let response = CartFoodsResponse(allCartFoods: nil)
                    handler(response)
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    static func addFoodToCart(foodName: String, foodImageName: String, foodPrice: Int, cartFoodNumber: Int, username: String, handler: @escaping  (Bool) -> Void) {
        let params:Parameters = ["yemek_adi": foodName, "yemek_resim_adi": foodImageName, "yemek_fiyat": foodPrice, "yemek_siparis_adet": cartFoodNumber, "kullanici_adi": username]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php",method: .post, parameters: params).response { response in
            if let data = response.data {
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        print(json)
                    }
                    handler(true)
                }catch{
                    print(error.localizedDescription)
                    handler(false)
                }
            }
        }
    }
    
    static func deleteFoodFromCart(cartFoodId: Int, username: String, handler: @escaping  (Bool) -> Void) {
        let params:Parameters = ["sepet_yemek_id":cartFoodId, "kullanici_adi": username]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post, parameters: params).response { response in
           
            if let data = response.data {
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        print(json)
                        handler(true)
                    }
                }catch{
                    print(error.localizedDescription)
                    handler(false)
                }
            }
        }
    }
}
