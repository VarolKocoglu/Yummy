//
//  FoodDetailPresenter.swift
//  Yummy
//
//  Created by varol on 11.01.2022.
//

import Foundation

class FoodDetailPresenter: ViewToPresenterFoodDetailProtocol {
    var foodDetailInteractor: PresenterToInteractorFoodDetailProtocol?

    func addToCart(foodName: String, foodImageName: String, foodPrice: Int, cartFoodNumber: Int, username: String) {
        foodDetailInteractor?.addFoodToCart(foodName: foodName, foodImageName: foodImageName, foodPrice: foodPrice, cartFoodNumber: cartFoodNumber, username: staticUserName)
    }
    
    func deleteFoodFromCart(foodName: String, username: String) {
        foodDetailInteractor?.deleteFoodFromCart(foodName: foodName, username: staticUserName)
    }
    
}
