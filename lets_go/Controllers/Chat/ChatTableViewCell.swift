//
//  ChatTableViewCell.swift
//  lets_go
//
//  Created by Ishan Singla on 01/05/24.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var chatImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var dateTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        chatImage.image = UIImage(systemName: "person.circle")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
