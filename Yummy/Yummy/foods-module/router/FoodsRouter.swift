//
//  FoodsRouter.swift
//  Yummy
//
//  Created by varol on 10.01.2022.
//

import Foundation

class FoodsRouter: PresenterToRouterFoodsProtocol {
    
    static func createModule(ref: FoodsViewController) {
        let presenter = FoodsPresenter()
        
        ref.foodsPresenterObject = presenter
        
        ref.foodsPresenterObject?.foodsInteractor = FoodsInteractor()
        ref.foodsPresenterObject?.foodsView = ref
        
        ref.foodsPresenterObject?.foodsInteractor?.foodsPresenter = presenter
    }
}
