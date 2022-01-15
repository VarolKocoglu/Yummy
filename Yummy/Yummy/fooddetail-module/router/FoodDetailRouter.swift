//
//  FoodDetailRouter.swift
//  Yummy
//
//  Created by varol on 11.01.2022.
//

import Foundation

class FoodDetailRouter: PresenterToRouterFoodDetailProtocol {
    static func createModule(ref: FoodDetailViewController) {
        ref.foodDetailPresenterObject = FoodDetailPresenter()
        ref.foodDetailPresenterObject?.foodDetailInteractor = FoodDetailInteractor()
    }
}
