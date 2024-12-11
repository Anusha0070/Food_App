//
//  FoodVM.swift
//  EscapingClosure
//
//  Created by Anusha Raju on 12/10/24.
//

import Foundation

class FoodViewModel{
    var networkManager: NetworkProtocol?
    
    var food: [Food] = []
    
    init(networkManager: NetworkProtocol?) {
        self.networkManager = networkManager
    }

    func getFoodData(urlString: String, closure: @escaping () -> ()){
        networkManager?.getData(from: urlString)
        { [weak self] (data: FoodData) in
           
            self?.food = data.food_groups
//            print(self?.food)
        }
    }
    
    func getFoodItemDetails(section: Int) -> [FoodItem]{
        return food[section].food_items
    }
    
    func getFoodCount()-> Int {
        return food.count
    }
    
    func getFoodForCategory(index: Int) -> Food {
        return food[index]
    }
}


