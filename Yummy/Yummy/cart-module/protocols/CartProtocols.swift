//
//  CartProtocols.swift
//  Yummy
//
//  Created by varol on 11.01.2022.
//

import Foundation

protocol PresenterToInteractorCartProtocol {
    var cartPresenter: InteractorToPresenterCartProtocol? {get set}
    
    func getAllCart(username: String)
    func addFoodToCart(foodName: String, foodImageName: String, foodPrice: Int, cartFoodNumber: Int, username: String)
    func deleteFoodFromCart(cartFoodId: Int, username: String)
}

protocol ViewToPresenterCartProtocol {
    var cartInteractor: PresenterToInteractorCartProtocol? {get set}
    var cartView: PresenterToViewCartProtocol? {get set}
    
    func loadCard(username: String)
    func deleteFromCart(cartFoodId: Int, username: String)
    func addToCart(foodName: String, foodImageName: String, foodPrice: Int, cartFoodNumber: Int, username: String)
}

protocol InteractorToPresenterCartProtocol {
    func sendCartListToPresenter(cartList: Array<CartFoods>)
}

protocol PresenterToViewCartProtocol {
    func sendCartListToView(cartList: Array<CartFoods>)
}

protocol PresenterToRouterCartProtocol {
    static func createModule(ref: CartViewController)
}
