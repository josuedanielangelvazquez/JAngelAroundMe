//
//  CategoriesTableViewCell.swift
//  JAngelAroundMe
//
//  Created by MacBookMBA6 on 22/03/23.
//

import UIKit
import SwipeCellKit

class CategoriesTableViewCell: SwipeTableViewCell {

    
    @IBOutlet weak var categorylbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
