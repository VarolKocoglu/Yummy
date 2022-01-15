//
//  CartPresenter.swift
//  Yummy
//
//  Created by varol on 11.01.2022.
//

import Foundation

class CartPresenter: ViewToPresenterCartProtocol {
    var cartInteractor: PresenterToInteractorCartProtocol?
    var cartView: PresenterToViewCartProtocol?
    
    func loadCard(username: String) {
        cartInteractor?.getAllCart(username: staticUserName)
    }
    
    func deleteFromCart(cartFoodId: Int, username: String) {
        cartInteractor?.deleteFoodFromCart(cartFoodId: cartFoodId, username: staticUserName)
    }
    
    func addToCart(foodName: String, foodImageName: String, foodPrice: Int, cartFoodNumber: Int, username: String) {
        cartInteractor?.addFoodToCart(foodName: foodName, foodImageName: foodImageName, foodPrice: foodPrice, cartFoodNumber: cartFoodNumber, username: staticUserName)
    }
}

extension CartPresenter: InteractorToPresenterCartProtocol {
    func sendCartListToPresenter(cartList: Array<CartFoods>) {
        cartView?.sendCartListToView(cartList: cartList)
    }
}
