//
//  ReplicatemydataViewController.swift
//  lets_go
//
//  Created by student on 30/04/24.
//

import UIKit

class ReplicatemydataViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    

    let data = [
           Trip(userName: "Ram", from: "Chitkara University", to: "Sector 23 Chandigarh", seatsAvailable: 3, timeOfDeparture: "3:30 PM", price: 120.0),
           Trip(userName: "Rohan", from: "Chitkara University", to: "Sector 35", seatsAvailable: 2, timeOfDeparture: "2:00 PM", price: 100.0)
       ]
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
           // Set up the table view
           tableView.dataSource = self
           
           // Register your custom UITableViewCell class
           tableView.register(TripCell.self, forCellReuseIdentifier: "TripCell")
       }
   }

   extension ReplicatemydataViewController: UITableViewDataSource {
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return data.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "TripCell", for: indexPath) as! TripCell
           let trip = data[indexPath.row]
           cell.configure(with: trip)
           return cell
       }
   }

   class TripCell: UITableViewCell {
       // Define UI elements
       let userNameLabel = UILabel()
       let fromLabel = UILabel()
       let toLabel = UILabel()
       let timeOfDepartureLabel = UILabel()
       let priceLabel = UILabel()
       
       // Image view for the fixed image
       let fixedImageView: UIImageView = {
           let imageView = UIImageView(image: UIImage(named: "person.crop.circle.fill")) 
           imageView.translatesAutoresizingMaskIntoConstraints = false
           return imageView
       }()
       
       // Array to store seat image views
       var seatImageViews: [UIImageView] = []
       
       override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           
           // Configure UI elements
           // Add UI elements to contentView
           contentView.addSubview(fixedImageView)
       }
       
       required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       // Configure cell with trip data
       func configure(with trip: Trip) {
           userNameLabel.text = "User: \(trip.userName)"
           fromLabel.text = "From: \(trip.from)"
           toLabel.text = "To: \(trip.to)"
           timeOfDepartureLabel.text = "Departure time: \(trip.timeOfDeparture)"
           priceLabel.text = "Price: \(trip.price)"
           
           // Clear existing seat image views
           for imageView in seatImageViews {
               imageView.removeFromSuperview()
           }
           seatImageViews.removeAll()
           
           
           let seatImage = UIImage(named: "carseat.right.fill")
           let maxSeats = min(trip.seatsAvailable, 4)
           for _ in 0..<maxSeats {
               let imageView = UIImageView(image: seatImage)
               contentView.addSubview(imageView)
               seatImageViews.append(imageView)
           }
       }
   }

   // Data model
   struct Trip {
       let userName: String
       let from: String
       let to: String
       let seatsAvailable: Int
       let timeOfDeparture: String
       let price: Double
   }
