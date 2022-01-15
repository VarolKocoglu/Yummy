//
//  OrderRouter.swift
//  Yummy
//
//  Created by varol on 15.01.2022.
//

import Foundation

class OrderRouter: PresenterToRouterOrderProtocol {
    static func createModule(ref: OrderViewController) {
        ref.orderPresenterObject = OrderPresenter()
        ref.orderPresenterObject?.orderInteractor = OrderInteractor()
    }
    

}
