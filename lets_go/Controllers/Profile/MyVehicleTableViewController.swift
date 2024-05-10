//
//  MyVehicleTableViewController.swift
//  lets_go
//
//  Created by student on 09/05/24.
//

import UIKit

class MyVehicleTableViewController: UITableViewController {
    
    private var data: [Vehicle] = [
        Vehicle(
           id: "1",
           userId: "1",
           vehicleName: "Honda City",
           vehicleNumber: "PB08 1234",
           vehicleType: "Car"
       ),

        Vehicle(
           id: "1",
           userId: "1",
           vehicleName: "baleno",
           vehicleNumber: "CH01 4325",
           vehicleType: "Car"
       ),
        Vehicle(
           id: "1",
           userId: "1",
           vehicleName: "Swift",
           vehicleNumber: "CH02 4354",
           vehicleType: "Car"
       ),
        Vehicle(
           id: "1",
           userId: "1",
           vehicleName: "Honda City",
           vehicleNumber: "PB08 1234",
           vehicleType: "Car"
       ),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "vehicle", for: indexPath) as! VehicleTableViewCell
        
        // Configure the cell...
        let vehicle = data[indexPath.row]
        cell.vehiclename.text = "\(vehicle.vehicleName)"
        cell.vehiclenumber.text = "\(vehicle.vehicleNumber)"
    
//        cell.textLabel?.text = "\(vehicle.vehicleName) \(vehicle.vehicleNumber)"
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}
