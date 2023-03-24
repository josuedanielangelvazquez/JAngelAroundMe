//
//  DetailTableViewCell.swift
//  JAngelAroundMe
//
//  Created by MacBookMBA6 on 24/03/23.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var ViewImageIcons: UIView!
    @IBOutlet weak var ImageIcons: UIImageView!
    @IBOutlet weak var Detaillbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
