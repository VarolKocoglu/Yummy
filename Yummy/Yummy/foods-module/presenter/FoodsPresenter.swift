//
//  FoodsPresenter.swift
//  Yummy
//
//  Created by varol on 10.01.2022.
//

import Foundation


class FoodsPresenter: ViewToPresenterFoodsProtocol {
    var foodsInteractor: PresenterToInteractorFoodsProtocol?
    var foodsView: PresenterToViewFoodsProtocol?

    func loadFoods() {
        foodsInteractor?.getAllFoods()
    }
    
    func addToCart(foodName: String, foodImageName: String, foodPrice: Int, cartFoodNumber: Int, username: String) {
        foodsInteractor?.addFoodToCart(foodName: foodName, foodImageName: foodImageName, foodPrice: foodPrice, cartFoodNumber: cartFoodNumber, username: username)
    }
    
    func deleteFoodFromCart(foodName: String, username: String) {
        foodsInteractor?.deleteFoodFromCart(foodName: foodName, username: username)
    }
    
    func searchFoods(word: String) {
        foodsInteractor?.searchFood(word: word)
    }
    
}

extension FoodsPresenter: InteractorToPresenterFoodsProtocol {
    
    func sendFoodsListToPresenter(foodsList: Array<Foods>) {
        foodsView?.sendFoodsListToView(foodsList: foodsList)
    }
    
}
