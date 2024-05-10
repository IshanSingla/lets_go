//
//  VehicleTableViewCell.swift
//  lets_go
//
//  Created by student on 10/05/24.
//

import UIKit

class VehicleTableViewCell: UITableViewCell {

    @IBOutlet weak var vehiclenumber: UILabel!
    @IBOutlet weak var vehiclename: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
