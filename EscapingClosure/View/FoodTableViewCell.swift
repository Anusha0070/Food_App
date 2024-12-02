//
//  FoodTableViewCell.swift
//  EscapingClosure
//
//  Created by Anusha Raju on 12/2/24.
//

import UIKit

class FoodTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var foodDescription: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
