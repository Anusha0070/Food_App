//
//  FoodDataVC.swift
//  EscapingClosure
//
//  Created by Anusha Raju on 12/2/24.
//

import UIKit

class FoodDataVC: UIViewController {

    @IBOutlet weak var foodTableView: UITableView!
    var foodData: [Food]?

    //MARK: - View Controller's Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadData()
    }
    
    //MARK: - Helper
    func configureTableView(){
        foodTableView.dataSource = self
    }
    
    func reloadTableView(){
        foodTableView?.reloadData()
    }
    
    //MARK: - API Method
    func loadData(){
        let sharedInstance = Network.sharedInstance
        sharedInstance.getData(from: ServerConstants.serverURL)
        { data in
            DispatchQueue.main.async {
                self.foodData = data.food_groups
                self.reloadTableView()
            }
        }
    }
}

//MARK: - Table View Methods
extension FoodDataVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodData?[section].food_items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath) as! FoodTableViewCell

        configureCell(cell, at: indexPath)
        return cell
    }
    
    //MARK: - Helper method to configure the cell
    func configureCell(_ cell: FoodTableViewCell, at indexPath: IndexPath) {
        guard let food = getFoodItem(at: indexPath) else { return }
        cell.name.text = "\(food.name)"
        cell.foodDescription.text = "Description: \(food.description)"
        cell.foodPrice.text = "Price: $\(food.price)"
    }
    
    //MARK: - Helper function to get the food item at a specific index path
    func getFoodItem(at indexPath: IndexPath) -> FoodItem? {
        guard let foodList = foodData?[indexPath.section].food_items else { return nil }
        guard indexPath.row < foodList.count else { return nil }
        return foodList[indexPath.row]
    }
}

