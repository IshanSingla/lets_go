//
//  AddressTableViewCell.swift
//  lets_go
//
//  Created by student on 10/05/24.
//

import UIKit

class AddressTableViewCell: UITableViewCell {

    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var pin: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
    }

}
