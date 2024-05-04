//
//  MyRideViewController.swift
//  lets_go
//
//  Created by Ishan Singla on 25/04/24.
//

import UIKit

class MyRideViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var data: [Rides] = [
        Rides(
            userId: "1",
            user: User(
                id: "1",
                name: "Kaushiv",
                email: "",
                rollnumber: "",
                department: "",
                collegeId: ""
            ),
            vehicleId: "1",
            vehicle: Vehicle(
                id: "1",
                userId: "1",
                vehicleName: "Honda City",
                vehicleNumber: "PB08 1234",
                vehicleType: "Car"
            ),
            fromId: "1",
            toId: "1",
            from: Address(
                id: "1",
                userId: "1",
                address: "Chitkara University",
                city: "Rajpura",
                state: "Punjab",
                country: "India",
                pincode: "140401"
            ),
            to: Address(
                id: "1",
                userId: "1",
                address: "118/2 Rajpura",
                city: "Rajpura",
                state: "Punjab",
                country: "India",
                pincode: "140401"
            ),
            
            totalNoOfSeets: 3,
            noOfSeetsAvailable: 3,
            costPerSeet: 100,
            dateTime: Date(),
            bookings: []
        ),
        Rides(
            userId: "1",
            user: User(
                id: "1",
                name: "Kaushiv",
                email: "",
                rollnumber: "",
                department: "",
                collegeId: ""
            ),
            vehicleId: "1",
            vehicle: Vehicle(
                id: "1",
                userId: "1",
                vehicleName: "Honda City",
                vehicleNumber: "PB08 1234",
                vehicleType: "Car"
            ),
            fromId: "1",
            toId: "1",
                
            from: Address(
                id: "1",
                userId: "1",
                address: "Chitkara University",
                city: "Rajpura",
                state: "Punjab",
                country: "India",
                pincode: "140401"
            ),
            to: Address(
                id: "1",
                userId: "1",
                address: "118/2 Rajpura",
                city: "Rajpura",
                state: "Punjab",
                country: "India",
                pincode: "140401"
            ),
            totalNoOfSeets: 3,
            noOfSeetsAvailable: 3,
            costPerSeet: 100,
            dateTime: Date(),
            bookings: []
        ),
        Rides(
            userId: "1",
            user: User(
                id: "1",
                name: "Kaushiv",
                email: "",
                rollnumber: "",
                department: "",
                collegeId: ""
            ),
            vehicleId: "1",
            vehicle: Vehicle(
                id: "1",
                userId: "1",
                vehicleName: "Honda City",
                vehicleNumber: "PB08 1234",
                vehicleType: "Car"
            ),
            fromId: "1",
            toId: "1",
            from: Address(
                id: "1",
                userId: "1",
                address: "Chitkara University",
                city: "Rajpura",
                state: "Punjab",
                country: "India",
                pincode: "140401"
            ),
            to: Address(
                id: "1",
                userId: "1",
                address: "118/2 Rajpura",
                city: "Rajpura",
                state: "Punjab",
                country: "India",
                pincode: "140401"
            ),
            totalNoOfSeets: 3,
            noOfSeetsAvailable: 3,
            costPerSeet: 100,
            dateTime: Date(),
            bookings: []
        ),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
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
        self.performSegue(withIdentifier: "MyRideSegue", sender: self)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let BookRideVC = segue.destination as! BookingByRideViewController
//       BookRideVC.publish = data[(tableView.indexPathForSelectedRow?.row)!]
//
//    }


}
