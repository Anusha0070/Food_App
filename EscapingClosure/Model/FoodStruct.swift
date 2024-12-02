//
//  FoodStruct.swift
//  EscapingClosure
//
//  Created by Anusha Raju on 12/2/24.
//

struct FoodData: Codable {
    let food_groups: [Food]
}

struct Food: Codable {
    let id: Int
    let name: String
    let description: String
    let image_url: String
    let food_items: [FoodItem]
}

struct FoodItem: Codable {
    let id: Int
    let name: String
    let description: String
    let weight: Int
    let price: Int
    let image_url: String
}
