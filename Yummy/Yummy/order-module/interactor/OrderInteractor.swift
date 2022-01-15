//
//  OrderInteractor.swift
//  Yummy
//
//  Created by varol on 15.01.2022.
//

import Foundation
import SwiftUI

class OrderInteractor: PresenterToInteractorOrderProtocol {
    func order() {
        CartWorker.getAllFoods(username: staticUserName) { response in
            
            if let allCartFoods = response.allCartFoods {
            for x in allCartFoods {
                if let tempCartFoodId = x.cartFoodId, let tempIntCartFoodId = Int(tempCartFoodId), let tempFoodName =  x.foodName {
                    userDefaultNumbers.set( 0, forKey: tempFoodName)
                    CartWorker.deleteFoodFromCart(cartFoodId: tempIntCartFoodId , username: staticUserName) { success in
                        
                        if (success) {
                            
                        }
                    }
                }
            }
        }
            }
    }
    
}
