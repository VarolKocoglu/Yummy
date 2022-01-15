//
//  SignPresenter.swift
//  Yummy
//
//  Created by varol on 15.01.2022.
//

import Foundation

class SignPresenter: ViewToPresenterSignProtocol{
    var signInteractor: PresenterToInteractorSignProtocol?
    
    func signIn(username: String, password: String) {
        signInteractor?.signIn(username: username, password: password)
    }
    
    func signUp(username: String, password: String) {
        signInteractor?.signIn(username: username, password: password)
    }
    
    
}
