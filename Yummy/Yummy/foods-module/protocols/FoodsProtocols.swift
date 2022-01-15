//
//  FoodsProtocols.swift
//  Yummy
//
//  Created by varol on 10.01.2022.
//

import Foundation

//Ana protocol
protocol PresenterToInteractorFoodsProtocol {
    var foodsPresenter: InteractorToPresenterFoodsProtocol? {get set}
    
    func getAllFoods()
    func addFoodToCart(foodName: String, foodImageName: String, foodPrice: Int, cartFoodNumber: Int, username: String)
    func deleteFoodFromCart(foodName: String, username: String)
    func searchFood(word: String)
}


protocol ViewToPresenterFoodsProtocol {
    var foodsInteractor: PresenterToInteractorFoodsProtocol? {get set}
    var foodsView: PresenterToViewFoodsProtocol? {get set}
    
    func loadFoods()
    func addToCart(foodName: String, foodImageName: String, foodPrice: Int, cartFoodNumber: Int, username: String)
    func deleteFoodFromCart(foodName: String, username: String)
    func searchFoods(word: String)
}


protocol InteractorToPresenterFoodsProtocol {
    func sendFoodsListToPresenter(foodsList: Array<Foods>)
}


protocol PresenterToViewFoodsProtocol {
    func sendFoodsListToView(foodsList: Array<Foods>)
}


protocol PresenterToRouterFoodsProtocol {
    static func createModule(ref: FoodsViewController)
}
