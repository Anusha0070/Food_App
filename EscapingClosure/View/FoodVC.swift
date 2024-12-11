//
//  FoodVC.swift
//  EscapingClosure
//
//  Created by Anusha Raju on 12/8/24.
//


import UIKit

class FoodVC: UIViewController {
    
    @IBOutlet weak var foodTableView: UITableView!
    var food: [Food]?
    var serverURL = ServerConstants.serverURL
    var foodViewModel : FoodViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadData()
        configureTableView()
        foodTableView.backgroundColor = .black
    }
    
    //MARK: - Helper
    func configureTableView(){
        foodTableView.dataSource = self
        foodTableView.delegate = self
    }
    
    func reloadTableView(){
        foodTableView?.reloadData()
    }
    
    func loadData(){
        foodViewModel?.getFoodData(urlString: serverURL, closure: {
            DispatchQueue.main.async{ [weak self] in
                self?.reloadTableView()
            }
        })
    }
}
//MARK: - Food View Controller TableView DataSource
extension FoodVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodViewModel?.getFoodCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as? MyCustomCell else {
            return UITableViewCell()
        }
        
        let foodNames = foodViewModel?.getFoodForCategory(index: indexPath.row)
        
        let imgURL = (foodNames?.image_url) ?? ""
        cell.foodName.text = foodNames?.name
        ImageDownloader.shared.getImage(url: imgURL) { [] image in
            DispatchQueue.main.async {
                cell.foodImg.image = image
            }
        }
        return cell
    }
}
//MARK: - Food View Controller TableView Delegate
extension FoodVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let newScreen = storyboard?.instantiateViewController(identifier: "FoodDataVC") as? FoodDataVC else {
            return
        }
        navigationController?.pushViewController(newScreen, animated: true)
        
        let foodItemDetails = foodViewModel?.getFoodItemDetails(section: indexPath.row) ?? []
        newScreen.foodItemDetails = foodItemDetails
    }
}
