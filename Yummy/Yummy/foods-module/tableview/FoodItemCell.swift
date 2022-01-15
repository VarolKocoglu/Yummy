//
//  FoodItemCell.swift
//  Yummy
//
//  Created by varol on 12.01.2022.
//

import UIKit

let urlImages =  "http://kasimadalan.pe.hu/yemekler/resimler/"
let tl = "TL"

protocol FoodItemDelegate: AnyObject {
    func didTouchAddToCart(cell: FoodItemCell)
    func didTouchDeleteCart(cell: FoodItemCell)
}

class FoodItemCell: UITableViewCell {

    @IBOutlet weak var foodView: UIView!
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodNumberLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    weak var delegate: FoodItemDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        foodView.layer.cornerRadius = 10
        minusButton.layer.cornerRadius = 5.0
        plusButton.layer.cornerRadius = 5.0
        
        if let foodLabelText = foodLabel.text {
            foodNumberLabel.text = String( userDefaultNumbers.integer(forKey: foodLabelText) )
        }
    }
    
    @IBAction func addToChart(_ sender: Any) {
        delegate?.didTouchAddToCart(cell: self)
        if let foodLabelText = foodLabel.text {
            foodNumberLabel.text = String( userDefaultNumbers.integer(forKey: foodLabelText) )
        }
    }
    @IBAction func deleteToChart(_ sender: Any) {
        delegate?.didTouchDeleteCart(cell: self)
        if let foodLabelText = foodLabel.text {
            foodNumberLabel.text = String( userDefaultNumbers.integer(forKey: foodLabelText) )
        }

    }
    
    func configure(with food: Foods) {
        if let foodNameText = food.foodName, let foodPriceText = food.foodPrice, let fooImageName = food.foodImageName {
            foodLabel.text = foodNameText
            foodImageView.kf.setImage(with:URL(string: "\(urlImages)\(fooImageName)"))
            foodPrice.text = "\(foodPriceText) \(tl)"
            foodNumberLabel.text = String( userDefaultNumbers.integer(forKey: foodNameText) )
        }

    }
    
}
