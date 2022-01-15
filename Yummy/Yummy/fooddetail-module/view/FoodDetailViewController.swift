//
//  FoodDetailViewController.swift
//  Yummy
//
//  Created by varol on 11.01.2022.
//

import UIKit
import Kingfisher
import Firebase

class FoodDetailViewController: UIViewController {
    @IBOutlet weak var foodDetailView: UIView!
    @IBOutlet weak var foodDetailImageView: UIImageView!
    @IBOutlet weak var foodDetailFoodNameLabel: UILabel!
    @IBOutlet weak var foodDetailFoodPriceLabel: UILabel!
    @IBOutlet weak var foodDetailNumberLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    var food: Foods?
    
    var foodDetailPresenterObject: ViewToPresenterFoodDetailProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodDetailView.layer.masksToBounds = true
        foodDetailView.layer.cornerRadius = 10.0
        minusButton.layer.cornerRadius = 10.0
        plusButton.layer.cornerRadius = 10.0

        
        FoodDetailRouter.createModule(ref: self)

    }
    override func viewWillAppear(_ animated: Bool) {
        if let foodLabel = food?.foodName, let foodPrice = food?.foodPrice, let foodImage = food?.foodImageName {
            foodDetailFoodNameLabel.text = foodLabel
            foodDetailFoodPriceLabel.text = " \(foodPrice) \(tl)"
            foodDetailImageView.kf.setImage(with:URL(string: "\(urlImages)\(foodImage)"))
            foodDetailNumberLabel.text =  String (userDefaultNumbers.integer(forKey: foodDetailFoodNameLabel.text!) )
        }
    }
    
    @IBAction func logOut(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
          performSegue(withIdentifier: "toSign2", sender: nil)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    @IBAction func foodDecreaseNumberButton(_ sender: Any) {
        if let foodname = food?.foodName, let tempfoodDetailNumberLabel = foodDetailNumberLabel.text, let intFoodDetailNumberLabel = Int (tempfoodDetailNumberLabel) {
            foodDetailPresenterObject?.deleteFoodFromCart(foodName: foodname, username: staticUserName)
            foodDetailNumberLabel.text = String ( intFoodDetailNumberLabel - 1 )
        }
    }
    
    @IBAction func foodIncreaseNumberButton(_ sender: Any) {
        if let tempFood = food, let foodLabel = tempFood.foodName, let foodPrice = tempFood.foodPrice, let intFoodPrice = Int(foodPrice), let foodImage = tempFood.foodImageName, let tempFoodDetailFoodNameLabel = foodDetailFoodNameLabel.text {
            foodDetailPresenterObject?.addToCart(foodName: foodLabel, foodImageName: foodImage, foodPrice: intFoodPrice, cartFoodNumber: userDefaultNumbers.integer(forKey: tempFoodDetailFoodNameLabel), username: staticUserName)
            if let tempFoodDetailNumberLabel = foodDetailNumberLabel.text, let tempIntFoodDetailNumberLabel = Int(tempFoodDetailNumberLabel) {
                foodDetailNumberLabel.text = String ( tempIntFoodDetailNumberLabel + 1 )
            }
        }
    }
    
}
