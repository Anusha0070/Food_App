//
//  FoodDataVC.swift
//  EscapingClosure
//
//  Created by Anusha Raju on 12/2/24.
//

import UIKit

class FoodDataVC: UIViewController {

    @IBOutlet weak var foodTableView: UITableView!
    var food: [Food]?
    var foodItemDetails : [FoodItem] = []
    var foodViewModel : FoodViewModel?
    var serverURL = ServerConstants.serverURL

    //MARK: - View Controller's Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadItemData()
    }
    
    //MARK: - Helper
    func configureTableView(){
        foodTableView.dataSource = self
    }
    
    func reloadTableView(){
        foodTableView?.reloadData()
    }
    
    func loadItemData(){
        foodViewModel?.getFoodData(urlString: serverURL, closure: {
            DispatchQueue.main.async{ [weak self] in
                self?.reloadTableView()
            }
        })
    }
    
}

//MARK: - Table View Methods
extension FoodDataVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodItemDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath) as! FoodTableViewCell
        getFoodItemDetails(cell, at: indexPath)
        return cell
    }
    
    func getFoodItemDetails(_ cell: FoodTableViewCell, at indexPath:IndexPath) {
        let list = foodItemDetails[indexPath.row]
        let imgURL = list.image_url
        
        cell.name.text = "\(String(describing: list.name))"
        cell.foodDescription.text = "Description: \(String(describing: list.description))"
        cell.foodPrice.text = "Price: $\(String(describing: list.price))"
        
        ImageDownloader.shared.getImage(url: imgURL) { [] image in
            DispatchQueue.main.async {
                cell.itemImg.image = image
            }
        }
    }
}



