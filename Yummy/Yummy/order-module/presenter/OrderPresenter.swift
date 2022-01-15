//
//  OrderPresenter.swift
//  Yummy
//
//  Created by varol on 15.01.2022.
//

import Foundation

class OrderPresenter: ViewToPresenterOrderProtocol {
    var orderInteractor: PresenterToInteractorOrderProtocol?
    
    func order() {
        orderInteractor?.order()
    }
    
    
}
