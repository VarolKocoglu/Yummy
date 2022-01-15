//
//  SignRouter.swift
//  Yummy
//
//  Created by varol on 15.01.2022.
//

import Foundation

class SignRouter: PresenterToRouterSignProtocol {
    static func createModule(ref: SignViewController) {
        ref.signPresenterObject = SignPresenter()
        ref.signPresenterObject?.signInteractor = SignIntercator()
    }
    

}
