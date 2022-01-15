//
//  CartViewController.swift
//  Yummy
//
//  Created by varol on 11.01.2022.
//

import UIKit
import SwiftUI
import Firebase

let cartCell = "cartCell"

class CartViewController: UIViewController {
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var totalCostLabel: UILabel!
    
    var cartList = [CartFoods]()
    var cartPresenterObject: ViewToPresenterCartProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartTableView.delegate = self
        cartTableView.dataSource = self
        
        CartRouter.createModule(ref: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cartPresenterObject?.loadCard(username: staticUserName)
    }

    @IBAction func logOut(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
          performSegue(withIdentifier: "toSign3", sender: nil)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }

    }
    @IBAction func toOrderButton(_ sender: Any) {
        if let totalCostLabel = totalCostLabel.text {
            if totalCostLabel != "0 TL"{
                performSegue(withIdentifier: "toOrder", sender: nil)
        }
            }
    }
}

extension CartViewController: PresenterToViewCartProtocol {
    func sendCartListToView(cartList: Array<CartFoods>) {
        var totalValue = 0
        self.cartList = cartList.sorted(by: {$0.foodName! > $1.foodName!})
        cartList.forEach { list in
            if let foodPrice = list.foodPrice, let intFoodPrice = Int(foodPrice), let cartFoodNumber = list.cartFoodNumber, let intCartFoodNumber = Int(cartFoodNumber) {
                totalValue += intFoodPrice * intCartFoodNumber
            }
        }
        self.totalCostLabel.text = "\(String(totalValue)) \(tl)"
        DispatchQueue.main.async {
            self.cartTableView.reloadData()
        }
        
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cart = cartList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cartCell,for: indexPath) as! CartTableViewCell
        if let cartLabel = cart.foodName,
           let cartPrice = cart.foodPrice,
           let cartNumber = cart.cartFoodNumber {
            cell.cartFoodNameLabel.text = cartLabel
            cell.cartFoodPriceLabel.text = "\(cartPrice) \(tl)"
            cell.cartFoodNumberLabel.text = cartNumber
        }
        cell.cartDelegate = self
        return cell
    }
}


extension CartViewController: CartDelegate {
    func didTocuhDecreaseNumber(cell: CartTableViewCell) {
            guard let indexPath = cartTableView.indexPath(for: cell) else {
                return
            }
            let cartFood = cartList[indexPath.row]
        if let cartFoodId = cartFood.cartFoodId, let intCartFoodId = Int(cartFoodId) {
            cartPresenterObject?.deleteFromCart(cartFoodId: intCartFoodId, username: staticUserName)
        }
        
    }
    
    func didTouchIncreaseNumber(cell: CartTableViewCell) {
        guard let indexPath = cartTableView.indexPath(for: cell) else {
            return
        }
        let cartFood = cartList[indexPath.row]
        if let cartFoodName = cartFood.foodName, let cartFoodImageName = cartFood.foodImageName, let cartFoodPrice = cartFood.foodPrice, let intCartFoodPrice = Int(cartFoodPrice), let cartFoodNumber = cartFood.cartFoodNumber, let intCartFoodNumber = Int(cartFoodNumber) {
            cartPresenterObject?.addToCart(foodName: cartFoodName, foodImageName: cartFoodImageName, foodPrice: intCartFoodPrice, cartFoodNumber: intCartFoodNumber, username: staticUserName)
        }

    }
}
