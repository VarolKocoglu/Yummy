//
//  FoodsViewController.swift
//  Yummy
//
//  Created by varol on 10.01.2022.
//

import UIKit
import Kingfisher
import Firebase

let  staticUserName = "varol_kocoglu"
let  staticToDetail = "toDetail"
let  cellNotFount = "Cell not found"

class FoodsViewController: UIViewController {

    @IBOutlet weak var foodsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var foodsList = [Foods]()
    var foodsPresenterObject: ViewToPresenterFoodsProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        foodsTableView.registerNib(cell: FoodItemCell.self)

        foodsTableView.delegate = self
        foodsTableView.dataSource = self
        
        FoodsRouter.createModule(ref: self)
        foodsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    @IBAction func logOut(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
          performSegue(withIdentifier: "toSign", sender: nil)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        foodsPresenterObject?.loadFoods()
        DispatchQueue.main.async {
            self.foodsTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == staticToDetail {
            let food = sender as? Foods
            let toVievController = segue.destination as! FoodDetailViewController
            toVievController.food = food
        }
    }
}

extension FoodsViewController : PresenterToViewFoodsProtocol {
    
    func sendFoodsListToView(foodsList: Array<Foods>) {
        self.foodsList = foodsList
        DispatchQueue.main.async {
            self.foodsTableView.reloadData()
        }
    }
}

extension FoodsViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        foodsPresenterObject?.searchFoods(word: searchText)
    }
}

extension FoodsViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let food = foodsList[indexPath.row]
        guard let cell = tableView.dequeCell(cell: FoodItemCell.self, indexPath: indexPath) else {
            fatalError(cellNotFount)
        }
        cell.configure(with: food)
        cell.delegate = self
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let food = foodsList[indexPath.row]
        performSegue(withIdentifier: staticToDetail, sender: food)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FoodsViewController: FoodItemDelegate {
    
    func didTouchAddToCart(cell: FoodItemCell) {
        guard let indexPath = foodsTableView.indexPath(for: cell) else {
            return
        }
        let food = foodsList[indexPath.row]
        if let foodName = food.foodName, let foodImageName = food.foodImageName, let foodPrice = food.foodPrice, let intFoodPrice = Int(foodPrice) {
            foodsPresenterObject?.addToCart(foodName: foodName, foodImageName: foodImageName, foodPrice: intFoodPrice, cartFoodNumber: 1, username: staticUserName)
        }
        
    }
    
    func didTouchDeleteCart(cell: FoodItemCell) {
        guard let indexPath = foodsTableView.indexPath(for: cell) else {
            return
        }
        let food = foodsList[indexPath.row]
        if let foodName = food.foodName {
            foodsPresenterObject?.deleteFoodFromCart(foodName: foodName, username: staticUserName)
        }
        
    }
    
}
