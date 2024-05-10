//
//  MyAddressTableViewController.swift
//  lets_go
//
//  Created by student on 10/05/24.
//

import UIKit

class MyAddressTableViewController: UITableViewController {
    
    private var data: [Address] = [
        Address(
            id: "1",
            userId: "1",
            address: "Chitkara University",
            city: "Rajpura",
            state: "Punjab",
            country: "India",
            pincode: "140401"
        ),
        Address(
            id: "1",
            userId: "1",
            address: "118/2 Rajpura",
            city: "Rajpura",
            state: "Punjab",
            country: "India",
            pincode: "140401"
        ),
        Address(
            id: "1",
            userId: "1",
            address: "118/2 Kaithal",
            city: "Rajpura",
            state: "Punjab",
            country: "India",
            pincode: "140401"
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "address", for: indexPath) as! AddressTableViewCell
        
        // Configure the cell...
        let address = data[indexPath.row]
        cell.address.text = "\(address.address) \(address.city)"
        cell.country.text = "\(address.state), \(address.country)"
        cell.pin.text = "\(address.pincode)"
//        cell.textLabel?.text =  "\(address.address) \(address.city)"
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }

}
