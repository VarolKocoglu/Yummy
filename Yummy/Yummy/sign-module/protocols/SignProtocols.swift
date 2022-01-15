//
//  File.swift
//  Yummy
//
//  Created by varol on 15.01.2022.
//

import Foundation

protocol PresenterToInteractorSignProtocol {
    func signUp(username: String, password: String,  handler: @escaping  (Bool) -> Void)
    func signIn(username: String, password: String)
}

protocol ViewToPresenterSignProtocol {
    var signInteractor: PresenterToInteractorSignProtocol? {get set}
    
    func signIn(username: String, password: String)
    func signUp(username: String, password: String)
}

protocol PresenterToRouterSignProtocol {
    static func createModule(ref: SignViewController)
}
