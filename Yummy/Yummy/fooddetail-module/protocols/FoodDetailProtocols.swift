//
//  FoodDetailProtocols.swift
//  Yummy
//
//  Created by varol on 11.01.2022.
//

import Foundation

protocol PresenterToInteractorFoodDetailProtocol {
    func addFoodToCart(foodName: String, foodImageName: String, foodPrice: Int, cartFoodNumber: Int, username: String)
    func deleteFoodFromCart(foodName: String, username: String)
}

protocol ViewToPresenterFoodDetailProtocol {
    var foodDetailInteractor: PresenterToInteractorFoodDetailProtocol? {get set}
    
    func addToCart(foodName: String, foodImageName: String, foodPrice: Int, cartFoodNumber: Int, username: String)
    func deleteFoodFromCart(foodName: String, username: String)
}

protocol PresenterToRouterFoodDetailProtocol {
    static func createModule(ref: FoodDetailViewController)
}
