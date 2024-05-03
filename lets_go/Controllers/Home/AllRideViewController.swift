//
//  AllRideViewController.swift
//  lets_go
//
//  Created by Ishan Singla on 02/05/24.
//

import UIKit

class AllRideViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{

    @IBOutlet weak var tableView: UITableView!
    var data: [Publish] = [
        Publish(
            id: "1",
            publisherUserId: "1",
            publisherUser: User(
                id: "1",
                name: "Ishan",
                email: "",
                rollnumber: "",
                department: "",
                collegeId: ""
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
        Publish(
            id: "1",
            publisherUserId: "1",
            publisherUser: User(
                id: "1",
                name: "Ishan",
                email: "",
                rollnumber: "",
                department: "",
                collegeId: ""
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
        Publish(
            id: "1",
            publisherUserId: "1",
            publisherUser: User(
                id: "1",
                name: "Ishan",
                email: "",
                rollnumber: "",
                department: "",
                collegeId: ""
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
        cell.UserName.text = publish.publisherUser!.name
        cell.Seat1.image = publish.noOfSeetsAvailable < 1 ? UIImage(systemName: "carseat.right"): UIImage(systemName: "carseat.right.fill")
        cell.Seat2.image = publish.noOfSeetsAvailable < 2 ? UIImage(systemName: "carseat.right"): UIImage(systemName: "carseat.right.fill")
        cell.Seat3.image = publish.noOfSeetsAvailable < 3 ? UIImage(systemName: "carseat.right"): UIImage(systemName: "carseat.right.fill")
        cell.Seat4.image = publish.noOfSeetsAvailable < 4 ? UIImage(systemName: "carseat.right"): UIImage(systemName: "carseat.right.fill")
        
//
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "BookRideSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let BookRideVC = segue.destination as! BookRideViewController
       BookRideVC.publish = data[(tableView.indexPathForSelectedRow?.row)!]

    }


}
