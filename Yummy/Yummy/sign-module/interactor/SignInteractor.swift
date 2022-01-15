//
//  SignProtocols.swift
//  Yummy
//
//  Created by varol on 15.01.2022.
//

import Foundation
import Firebase

class SignIntercator: PresenterToInteractorSignProtocol {
    func signUp(username: String, password: String, handler: @escaping  (Bool) -> Void) {
        Auth.auth().createUser(withEmail: username, password: username){ authResult, error in
            if let error = error {
                print(error)
                handler(false)
                return
            }
            else {
                print("başarılı")
                handler(true)
            }
          }
    }
    
    func signIn(username: String, password: String) {
        Auth.auth().signIn(withEmail: username, password: password) { authResult, error in
            if let error = error {
                print(error)
                return
            }
        }
    }
    
    
}
