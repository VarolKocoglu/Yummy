//
//  CartTableViewCell.swift
//  Yummy
//
//  Created by varol on 12.01.2022.
//

import UIKit

protocol CartDelegate: AnyObject {
    func didTocuhDecreaseNumber(cell: CartTableViewCell)
    func didTouchIncreaseNumber(cell: CartTableViewCell)
}

class CartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cartFoodNameLabel: UILabel!
    @IBOutlet weak var cartFoodPriceLabel: UILabel!
    @IBOutlet weak var cartFoodNumberLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    
    weak var cartDelegate:  CartDelegate?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        minusButton.layer.cornerRadius = 10.0
        plusButton.layer.cornerRadius = 10.0
    }


    @IBAction func decreaseNumber(_ sender: Any) {
        cartDelegate?.didTocuhDecreaseNumber(cell: self)
    }
    
    @IBAction func increaseNumber(_ sender: Any) {
        cartDelegate?.didTouchIncreaseNumber(cell: self)
    }
}
