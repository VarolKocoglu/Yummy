//
//  FoodDetailInteractor.swift
//  Yummy
//
//  Created by varol on 11.01.2022.
//

import Foundation

class FoodDetailInteractor: PresenterToInteractorFoodDetailProtocol {
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
                                        userDefaultNumbers.set( (tempIntCartFoodNumber + 1), forKey: foodName)
                                        CartWorker.getAllFoods(username: username, handler: {_ in })
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                    CartWorker.addFoodToCart(foodName: foodName, foodImageName: foodImageName, foodPrice: foodPrice, cartFoodNumber: cartFoodNumber + 1, username: username) { success in
                        if (success) {
                            userDefaultNumbers.set(1, forKey: foodName)
                            CartWorker.getAllFoods(username: username, handler: {_ in})
                        }
                    }
                }
            }
    }
    
    func deleteFoodFromCart(foodName: String, username: String) {
        CartWorker.getAllFoods(username: username) { response in
            
            let item = response.allCartFoods?.first(where: { item in
                return item.foodName == String(foodName)
            })
            if let item = item {
                if let tempCartFoodNumber = item.cartFoodNumber, let tempIntCartFoodNumber = Int(tempCartFoodNumber), let tempCartFoodId = item.cartFoodId, let tempIntCartFoodId = Int(tempCartFoodId) {
                if tempIntCartFoodNumber > 1 {
                    CartWorker.deleteFoodFromCart(cartFoodId: tempIntCartFoodId , username: staticUserName) { success in
                        if (success) {
                            if let tempFoodName = item.foodName, let tempFoodImageName = item.foodImageName, let tempFoodPrice = item.foodPrice, let tempIntFoodPrice = Int(tempFoodPrice){
                                CartWorker.addFoodToCart(foodName: tempFoodName, foodImageName: tempFoodImageName, foodPrice: tempIntFoodPrice, cartFoodNumber: (tempIntCartFoodNumber - 1), username: staticUserName) { success  in
                                    if (success) {
                                        userDefaultNumbers.set((tempIntCartFoodNumber - 1), forKey: tempFoodName)
                                        CartWorker.getAllFoods(username: staticUserName, handler: { _ in
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
                            CartWorker.getAllFoods(username: staticUserName, handler: { list in
                            })
                        }
                    }
                }
            }
            }
        }
    }
    
    
}
