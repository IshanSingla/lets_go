//
//  MyRideTableViewCell.swift
//  lets_go
//
//  Created by Ishan Singla on 10/05/24.
//

import UIKit

class MyRideTableViewCell: UITableViewCell {

    @IBOutlet weak var UserAvtar: UIImageView!
    @IBOutlet weak var UserName: UILabel!

    @IBOutlet weak var RideTime: UILabel!
    @IBOutlet weak var RideAmount: UILabel!

    @IBOutlet weak var FromLocation: UILabel!
    @IBOutlet weak var ToLocation: UILabel!

    @IBOutlet weak var Seat3: UIImageView!
    @IBOutlet weak var Seat2: UIImageView!
    @IBOutlet weak var Seat1: UIImageView!
    @IBOutlet weak var Seat4: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        UserAvtar.image = UIImage(systemName: "person.crop.circle.fill")
        Seat1.image = UIImage(systemName: "carseat.right")
        Seat2.image = UIImage(systemName: "carseat.right")
        Seat3.image = UIImage(systemName: "carseat.right")
        Seat4.image = UIImage(systemName: "carseat.right")


        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
