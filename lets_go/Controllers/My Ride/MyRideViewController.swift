//
//  MyRideViewController.swift
//  lets_go
//
//  Created by Ishan Singla on 25/04/24.
//

import UIKit

class MyRideViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    private var data: [Rides] = []
    private var userRepo: UserRepository!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        userRepo = UserRepository()
        let user = userRepo.findAll()
        var vahicle = Vehicle(
            id: "1",
            userId: "1",
            vehicleName: "Honda City",
            vehicleNumber: "PB08 1234",
            vehicleType: "Car"
        )
        let from = Address(
            id: "1",
            userId: "1",
            address: "Chitkara University",
            city: "Rajpura",
            state: "Punjab",
            country: "India",
            pincode: "140401"
        )
        
        let to = Address(
            id: "1",
            userId: "1",
            address: "118/2 Rajpura",
            city: "Rajpura",
            state: "Punjab",
            country: "India",
            pincode: "140401"
        )
        data = [
            Rides(
                userId: "1",
                user: user.first,
                vehicleId: "1",
                vehicle: vahicle,
                fromId: "1",
                toId: "1",
                from: from,
                to: to,
                totalNoOfSeets: 3,
                noOfSeetsAvailable: 3,
                costPerSeet: 100,
                dateTime: Date(),
                bookings: []
            ),
            Rides(
                userId: "1",
                user: user[1],
                vehicleId: "1",
                vehicle: vahicle,
                fromId: "1",
                toId: "1",
                from: from,
                to: to,
                totalNoOfSeets: 3,
                noOfSeetsAvailable: 3,
                costPerSeet: 100,
                dateTime: Date(),
                bookings: []
            ),
            Rides(
                userId: "1",
                user: user[1],
                vehicleId: "1",
                vehicle: vahicle,
                fromId: "1",
                toId: "1",
                from: from,
                to: to,
                totalNoOfSeets: 3,
                noOfSeetsAvailable: 3,
                costPerSeet: 100,
                dateTime: Date(),
                bookings: []
            ),
        ]
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let publish = data[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ridecell") as! MyRideTableViewCell
        
        cell.FromLocation.text = publish.from!.address
        cell.ToLocation.text = publish.to!.address
        cell.RideAmount.text = "Rs \(publish.costPerSeet)"
        cell.RideTime.text = publish.dateTime.description
        cell.UserName.text = publish.user!.name
        cell.Seat1.image = publish.noOfSeetsAvailable < 1 ? UIImage(systemName: "carseat.right"): UIImage(systemName: "carseat.right.fill")
        cell.Seat2.image = publish.noOfSeetsAvailable < 2 ? UIImage(systemName: "carseat.right"): UIImage(systemName: "carseat.right.fill")
        cell.Seat3.image = publish.noOfSeetsAvailable < 3 ? UIImage(systemName: "carseat.right"): UIImage(systemName: "carseat.right.fill")
        
//
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "MyPublishesSegue", sender: self)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let BookRideVC = segue.destination as! BookingByRideViewController
//       BookRideVC.publish = data[(tableView.indexPathForSelectedRow?.row)!]
//
//    }


}
