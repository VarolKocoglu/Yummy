//
//  CartInteractor.swift
//  Yummy
//
//  Created by varol on 11.01.2022.
//

import Foundation
import Alamofire
import SwiftUI

class CartInteractor: PresenterToInteractorCartProtocol {
    let userDefault = UserDefaults.standard
    
    
    var cartPresenter: InteractorToPresenterCartProtocol?
    
    func getAllCart(username: String) {
        let params:Parameters = ["kullanici_adi": username]

        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php",method: .post, parameters: params).response { response in
            if let data = response.data {
                do{
                    let response = try JSONDecoder().decode(CartFoodsResponse.self, from: data)
                    
                    var list = [CartFoods]()
                    
                    if let tempList = response.allCartFoods {
                        list = tempList;
                    }
                    self.cartPresenter?.sendCartListToPresenter(cartList: list)
            
                }catch{
                    let list = [CartFoods]()
                    self.cartPresenter?.sendCartListToPresenter(cartList: list)
                    print(error.localizedDescription)
                }
            }
        }
    }

    func addFoodToCart(foodName: String, foodImageName: String, foodPrice: Int, cartFoodNumber: Int, username: String) {
        CartWorker.getAllFoods(username: username) { response in
            
            let item = response.allCartFoods?.first(where: { item in
                return item.foodName == foodName
            })
            if let item = item {
                if let tempCartFoodId = item.cartFoodId, let tempIntCartFoodId = Int(tempCartFoodId) {
                    CartWorker.deleteFoodFromCart(cartFoodId: tempIntCartFoodId , username: staticUserName) { success in
                        if (success) {
                            if let tempCartFoodNumber = item.cartFoodNumber, let tempIntCartFoodNumber = Int(tempCartFoodNumber) {
                                CartWorker.addFoodToCart(foodName: foodName, foodImageName: foodImageName, foodPrice: foodPrice, cartFoodNumber: (tempIntCartFoodNumber + 1), username: staticUserName) { success  in
                                    if (success) {
                                        //Düzelt
                                        userDefaultNumbers.set( (tempIntCartFoodNumber + 1), forKey: foodName)
                                        CartWorker.getAllFoods(username: username, handler: {list in
                                            if let allCartFoods = list.allCartFoods {
                                                self.cartPresenter?.sendCartListToPresenter(cartList: allCartFoods)
                                            }
                                        })
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                    CartWorker.addFoodToCart(foodName: foodName, foodImageName: foodImageName, foodPrice: foodPrice, cartFoodNumber: cartFoodNumber, username: username) { success in
                        if (success) {
                            userDefaultNumbers.set(1, forKey: foodName)
                            CartWorker.getAllFoods(username: username, handler: {list in
                                if let allCartFoods = list.allCartFoods {
                                    self.cartPresenter?.sendCartListToPresenter(cartList: allCartFoods)
                                }
                            })
                        }
                    }
                }
            }
    }

    func deleteFoodFromCart(cartFoodId: Int, username: String) {
            CartWorker.getAllFoods(username: username) { response in
                let item = response.allCartFoods?.first(where: { item in
                    return item.cartFoodId == String(cartFoodId)
                })
                if let item = item {
                    if let tempCartFoodNumber = item.cartFoodNumber, let tempIntCartFoodNumber = Int(tempCartFoodNumber), let tempCartFoodId = item.cartFoodId, let tempIntCartFoodId = Int(tempCartFoodId) {
                    if tempIntCartFoodNumber > 1 {
                        CartWorker.deleteFoodFromCart(cartFoodId: tempIntCartFoodId , username: username) { success in
                            if (success) {
                                if let tempFoodName = item.foodName, let tempFoodImageName = item.foodImageName, let tempFoodPrice = item.foodPrice, let tempIntFoodPrice = Int(tempFoodPrice){
                                CartWorker.addFoodToCart(foodName: tempFoodName, foodImageName: tempFoodImageName, foodPrice: tempIntFoodPrice, cartFoodNumber: (tempIntCartFoodNumber - 1), username: staticUserName) { success  in
                                    if (success) {
                                        userDefaultNumbers.set((tempIntCartFoodNumber - 1), forKey: item.foodName!)
                                        CartWorker.getAllFoods(username: username, handler: { list in
                                            if let allCartFoods = list.allCartFoods {
                                                self.cartPresenter?.sendCartListToPresenter(cartList: allCartFoods)
                                            }
                                        })
                                    }
                                }
                            }
                            }
                        }
                        
                    }else {
                        CartWorker.deleteFoodFromCart(cartFoodId: tempIntCartFoodId , username: staticUserName) { success in
                            if (success) {
                                if let tempFoodName = item.foodName {
                                    userDefaultNumbers.set(0, forKey: tempFoodName)
                                }
                                CartWorker.getAllFoods(username: username, handler: { list in
                                    if let newList = list.allCartFoods {
                                        self.cartPresenter?.sendCartListToPresenter(cartList: newList)
                                    } else {
                                        let list = [CartFoods]()
                                        self.cartPresenter?.sendCartListToPresenter(cartList: list)
                                    }
                                })
                            }
                        }
                    }
                }
                }
            }
    }

}
