//
//  PlacesTableViewCell.swift
//  JAngelAroundMe
//
//  Created by MacBookMBA6 on 22/03/23.
//

import UIKit

class PlacesTableViewCell: UITableViewCell {

    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var Directionlbl: UILabel!
    @IBOutlet weak var City: UILabel!
    
    @IBOutlet weak var Openlbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
