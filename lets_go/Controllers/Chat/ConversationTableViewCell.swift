//
//  ConversationTableViewCell.swift
//  lets_go
//
//  Created by Ishan Singla on 01/05/24.
//

import UIKit

class ConversationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var message: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        message.layer.cornerRadius = 10
        message.layer.masksToBounds = true
        message.lineBreakMode = .byWordWrapping
        message.numberOfLines = 0
        message.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
