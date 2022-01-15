//
//  OrderProtocols.swift
//  Yummy
//
//  Created by varol on 15.01.2022.
//

import Foundation

protocol PresenterToInteractorOrderProtocol {
    func order()
}

protocol ViewToPresenterOrderProtocol {
    var orderInteractor: PresenterToInteractorOrderProtocol? {get set}
    
    func order()
}

protocol PresenterToRouterOrderProtocol {
    static func createModule(ref: OrderViewController)
}
